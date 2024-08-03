### Source
https://flink.apache.org/2020/07/28/flink-sql-demo-building-an-end-to-end-streaming-application/

- check the connection to Kafka
```yaml
    environment:
      - KAFKA_ADVERTISED_LISTENERS=INSIDE://:9094,OUTSIDE://localhost:9092
      - KAFKA_LISTENERS=INSIDE://:9094,OUTSIDE://:9092
      - KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=INSIDE:PLAINTEXT,OUTSIDE:PLAINTEXT
      - KAFKA_INTER_BROKER_LISTENER_NAME=INSIDE
      - KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181
      - KAFKA_CREATE_TOPICS="user_behavior:1:1"
```

- explain the above yaml 
  - LISTENERS are what interfaces Kafka binds to. ADVERTISED_LISTENERS are how clients can connect.
  - In essence, KAFKA_LISTENERS is the address where Kafka is listening, while KAFKA_ADVERTISED_LISTENERS is the address Kafka tells others to use to connect to it. This distinction is particularly important in complex network setups, such as in cloud environments or when using Docker, where the internal network structure is different from the external network.
    - KAFKA_ADVERTISED_LISTENERS defines the listeners that are **advertised to clients and other brokers.** This setting has two listeners:
      INSIDE://:9094 is for communication within the Docker network (e.g., for other containers).
      OUTSIDE://localhost:9092 is for communication from outside the Docker network (e.g., your local machine).
      The INSIDE and OUTSIDE are just names to distinguish between different types of connections.
    - KAFKA_LISTENERS defines the listeners for **incoming connections to the Kafka broker**. It mirrors the KAFKA_ADVERTISED_LISTENERS setting but without specifying localhost for the OUTSIDE listener. This means the broker listens on port 9094 for internal connections and port 9092 for external connections.
  - KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=INSIDE:PLAINTEXT,OUTSIDE:PLAINTEXT 
    - This setting maps each listener name to a security protocol. In this case, both INSIDE and OUTSIDE listeners are using PLAINTEXT, which means there is no encryption or authentication on these connections. This is typical for development environments but not recommended for production.
  - KAFKA_INTER_BROKER_LISTENER_NAME=INSIDE 
    - This specifies which listener name Kafka brokers within the same cluster will use to communicate with each other. Here, it's set to INSIDE, meaning inter-broker communication will happen over the listener on port 9094. 
  - KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181 
    - Kafka uses Zookeeper for maintaining cluster state and configurations. This setting specifies the Zookeeper connection string. zookeeper:2181 indicates that Kafka should connect to Zookeeper at the hostname zookeeper on port 2181. In a Docker Compose setup, zookeeper would typically be the service name of the Zookeeper container. 
  - KAFKA_CREATE_TOPICS="user_behavior:1:1"
    - This is an optional setting used to create a Kafka topic automatically when the broker starts. The format is topic_name:num_partitions:replication_factor. Here, it's creating a topic named user_behavior with 1 partition and a replication factor of 1.


### create a table in Flink SQL CLI client
- connect to the Kafka topic and Kafka broker in the port 9094 (INSIDE)
- connect to the elastic search in the port 9200
- the port 9300 is for the elastic search client
- This port is used for internal communication between nodes within an Elasticsearch cluster.
  - It's the default port for the Elasticsearch transport layer, which is responsible for internal cluster communications like shard operations, cluster state updates, and more.
  - In a single-node setup (as indicated by discovery.type=single-node in your configuration), exposing port 9300 is not strictly necessary because there's no inter-node communication
- connect to the mysql in the port 3306

```sql
CREATE TABLE user_behavior (
    user_id BIGINT,
    item_id BIGINT,
    category_id BIGINT,
    behavior STRING,
    ts TIMESTAMP(3),
    proctime AS PROCTIME(),
    WATERMARK FOR ts AS ts - INTERVAL '5' SECOND
) WITH (
    'connector' = 'kafka',
    'topic' = 'user_behavior',
    'properties.bootstrap.servers' = 'kafka:9094',
    'properties.group.id' = 'testGroup',
    'scan.startup.mode' = 'latest-offset',
    'format' = 'csv'
);

CREATE TABLE buy_cnt_per_hour (
                                hour_of_day BIGINT,
                                buy_cnt BIGINT
) WITH (
    'connector' = 'elasticsearch-7', -- using elasticsearch connector
    'hosts' = 'http://elasticsearch:9200',  -- elasticsearch address
    'index' = 'buy_cnt_per_hour'  -- elasticsearch index name, similar to database table name
    );

INSERT INTO buy_cnt_per_hour
SELECT HOUR(TUMBLE_START(ts, INTERVAL '1' HOUR)), COUNT(*)
FROM user_behavior
WHERE behavior = 'buy'
GROUP BY TUMBLE(ts, INTERVAL '1' HOUR);

INSERT INTO buy_cnt_per_hour
SELECT HOUR(TUMBLE_START(ts, INTERVAL '1' HOUR)), COUNT(*)
FROM user_behavior
WHERE behavior = 'buy'
GROUP BY TUMBLE(ts, INTERVAL '1' HOUR);

CREATE TABLE cumulative_uv (
                             date_str STRING,
                             time_str STRING,
                             uv BIGINT,
                             PRIMARY KEY (date_str, time_str) NOT ENFORCED
) WITH (
    'connector' = 'elasticsearch-7',
    'hosts' = 'http://elasticsearch:9200',
    'index' = 'cumulative_uv'
    );

INSERT INTO cumulative_uv
SELECT date_str, MAX(time_str), COUNT(DISTINCT user_id) as uv
FROM (
       SELECT
         DATE_FORMAT(ts, 'yyyy-MM-dd') as date_str,
         SUBSTR(DATE_FORMAT(ts, 'HH:mm'),1,4) || '0' as time_str,
         user_id
       FROM user_behavior)
GROUP BY date_str;

CREATE TABLE category_dim (
                            sub_category_id BIGINT,
                            parent_category_name STRING
) WITH (
    'connector' = 'jdbc',
    'url' = 'jdbc:mysql://mysql:3306/flink',
    'table-name' = 'category',
    'username' = 'root',
    'password' = '123456',
    'lookup.cache.max-rows' = '5000',
    'lookup.cache.ttl' = '10min'
    );

CREATE TABLE top_category (
                            category_name STRING PRIMARY KEY NOT ENFORCED,
                            buy_cnt BIGINT
) WITH (
    'connector' = 'elasticsearch-7',
    'hosts' = 'http://elasticsearch:9200',
    'index' = 'top_category'
    );


CREATE VIEW rich_user_behavior AS
SELECT U.user_id, U.item_id, U.behavior, C.parent_category_name as category_name
FROM user_behavior AS U LEFT JOIN category_dim FOR SYSTEM_TIME AS OF U.proctime AS C
                                  ON U.category_id = C.sub_category_id;

INSERT INTO top_category
SELECT category_name, COUNT(*) buy_cnt
FROM rich_user_behavior
WHERE behavior = 'buy'
GROUP BY category_name;

-- when you want to quit the sql client
quit;
```


### Flink UI
- check the job status in the Flink UI
  - url: http://localhost:8081/#/overview

### Kibana
- check the data in the Kibana
  - url: http://localhost:5601

![img.png](img.png)
Azure
https://learn.microsoft.com/en-us/azure/architecture/example-scenario/data/stream-ingestion-synapse
https://learn.microsoft.com/en-us/azure/architecture/example-scenario/data/open-source-data-engine-stream-processing
https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/data/stream-processing-databricks
https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/data/stream-processing-stream-analytics

AWS
https://docs.aws.amazon.com/whitepapers/latest/build-modern-data-streaming-analytics-architectures/what-is-a-modern-streaming-data-architecture.html

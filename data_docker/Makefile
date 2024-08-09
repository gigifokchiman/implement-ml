POSTGRES_DB_PORT = 55432

HOSTNAME = localhost

AIRFLOW_PORT = 8080
DBT_PORT = 8080
TRINO_PORT = 28080
FLINK_PORT = 8081
DATAGEN_PORT = 8083
KAFAK_PORT = 9092
KAFKA_A_PORT = 29092
KIBANA_PORT = 5601
FLOWER_PORT = 5555
DBT_PORT = 8085
POSTGRES_DB_PORT = 55432
KIBANA_PORT = 5601

.PHONY: all
all: clean build start
#########
# clean
#########
.PHONY: clean
clean: clean_docker

.PHONY: clean_docker
clean_docker:
	@docker-compose down --volumes --remove-orphans
	@docker system prune -f
	@docker volume prune -f
	@docker network prune -f

#########
# build
#########
.PHONY: build
build:
	@echo "building docker compose"
	@docker-compose build

#########
# start
#########
.PHONY: start
start:
	@echo "starting airflow-init"
	@docker-compose -f docker-compose.yaml -f batch.yaml up -d airflow-init
	@echo "starting docker compose"
	@docker-compose -f docker-compose.yaml \
					-f data-stores.yaml \
					-f batch.yaml \
					-f stream.yaml \
					-f logging.yaml \
					-f stream-analytics.yaml \
					-f analytics.yaml \
					-f overlay-jaffle_shop.yaml \
					up -d


test_connectivity:
	@echo "airflow"
	@curl -s -o /dev/null -w "%{http_code}" http://$(HOSTNAME):$(AIRFLOW_PORT)
	@echo "dbt can be accessed at http://localhost:$(DBT_PORT)"
	@curl -s -o /dev/null -w "%{http_code}" http://$(HOSTNAME):$(DBT_PORT)

print-%:
	@echo $* = $($*)


docker_ps_sort:
	@docker ps --format "table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.Status}}" | sort


#
#curl -X POST -H "Content-Type: application/json" --data @app/pageviewscount/datagen/connector_pageviews.config http://localhost:8083/connectors
#
#curl -X POST -H "Content-Type: application/json" --data @app/pageviewscount/kafka-connect/connector_elasticsearch.config http://localhost:8083/connectors
#

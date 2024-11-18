KAFKA_CONNECT_HOST := localhost
KAFKA_CONNECT_PORT := 28083
KAFKA_CONNECT_CONNECTOR_NAME := elasticsearch-sink
CONFIG_FILE := connector_elasticsearch.config

all: delete add status

.PHONY: list
list:
	@curl -X GET "http://$(KAFKA_CONNECT_HOST):$(KAFKA_CONNECT_PORT)/connectors"

.PHONY: is_topic
is_topic:
	@echo $$(curl -s -X GET -H "Content-Type: application/json" "http://$(KAFKA_CONNECT_HOST):$(KAFKA_CONNECT_PORT)/connectors" | grep -o $(KAFKA_CONNECT_CONNECTOR_NAME) | wc -l)

.PHONY: add
add:
	@curl -X POST "http://$(KAFKA_CONNECT_HOST):$(KAFKA_CONNECT_PORT)/connectors" -H "Content-Type: application/json" -d @$(CONFIG_FILE)

.PHONY: delete
delete:
	@curl -X DELETE "http://$(KAFKA_CONNECT_HOST):$(KAFKA_CONNECT_PORT)/connectors/$(KAFKA_CONNECT_CONNECTOR_NAME)"

.PHONY: restart
restart:
	@curl -X POST "http://$(KAFKA_CONNECT_HOST):$(KAFKA_CONNECT_PORT)/connectors/$(KAFKA_CONNECT_CONNECTOR_NAME)/restart"

.PHONY: status
status:
	@curl -s -X GET "http://$(KAFKA_CONNECT_HOST):$(KAFKA_CONNECT_PORT)/connectors/$(KAFKA_CONNECT_CONNECTOR_NAME)/status"

.PHONY: pause
pause:
	@curl -X PUT "http://$(KAFKA_CONNECT_HOST):$(KAFKA_CONNECT_PORT)/connectors/$(KAFKA_CONNECT_CONNECTOR_NAME)/pause"

.PHONY: resume
resume:
	@curl -X PUT "http://$(KAFKA_CONNECT_HOST):$(KAFKA_CONNECT_PORT)/connectors/$(KAFKA_CONNECT_CONNECTOR_NAME)/resume"

kafka_sample_streams.log:
	@echo "Starting Kafka stream operations..." && \
	echo "Streams from connect from beginning" > $@ && \
	docker-compose exec connect kafka-console-consumer --topic $(TOPIC_NAME) --bootstrap-server kafka:29092 --property print.key=true --max-messages 3 --from-beginning >> $@ 2>/dev/null || \
	(echo "Error: Failed to get streams from connect from beginning" >&2 && exit 1)
	@echo "Streams from kafka from beginning" >> $@ && \
	docker-compose exec kafka kafka-console-consumer --topic $(TOPIC_NAME) --bootstrap-server kafka:29092 --property print.key=true --max-messages 3 --from-beginning >> $@ 2>/dev/null || \
	(echo "Error: Failed to get streams from kafka from beginning" >&2 && exit 1)
	@echo "Streams from connect" >> $@ && \
	docker-compose exec connect kafka-console-consumer --topic $(TOPIC_NAME) --bootstrap-server kafka:29092 --property print.key=true --max-messages 3 >> $@ 2>/dev/null || \
	(echo "Error: Failed to get streams from connect" >&2 && exit 1)
	@echo "Streams from kafka" >> $@ && \
	docker-compose exec kafka kafka-console-consumer --topic $(TOPIC_NAME) --bootstrap-server kafka:29092 --property print.key=true --max-messages 3 >> $@ 2>/dev/null || \
	(echo "Error: Failed to get streams from kafka" >&2 && exit 1)
	@echo "All Kafka stream operations completed successfully."


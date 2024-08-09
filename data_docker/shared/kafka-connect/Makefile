KAFKA_CONNECT_HOST := localhost
KAFKA_CONNECT_PORT := 28083
KAFKA_CONNECT_CONNECTOR_NAME := elasticsearch-sink
CONFIG_FILE := connector_elasticsearch.config

all: delete add status

download_connector:
	@curl -O https://confluent-hub-client.s3-us-west-2.amazonaws.com/confluent-hub-client-2.0.0.tar.gz
	@tar -xvzf confluent-hub-client-2.0.0.tar.gz
	@mv confluent-hub-client-2.0.0/bin/confluent-hub /usr/local/bin
	@rm -rf confluent-hub-client-2.0.0.tar.gz confluent-hub-client-2.0.0

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


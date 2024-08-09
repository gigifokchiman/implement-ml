KAFKA_CONNECT_HOST := localhost
KAFKA_CONNECT_PORT := 8083
KAFKA_CONNECT_CONNECTOR_NAME := datagen-pageviews
CONFIG_FILE := connector_pageviews.config

list:
	@curl -X GET "http://$(KAFKA_CONNECT_HOST):$(KAFKA_CONNECT_PORT)/connectors"

add:
	@curl -X POST "http://$(KAFKA_CONNECT_HOST):$(KAFKA_CONNECT_PORT)/connectors" -H "Content-Type: application/json" -d @$(CONFIG_FILE)

delete:
	@curl -X DELETE "http://$(KAFKA_CONNECT_HOST):$(KAFKA_CONNECT_PORT)/connectors/$(KAFKA_CONNECT_CONNECTOR_NAME)"

restart:
	@curl -X POST "http://$(KAFKA_CONNECT_HOST):$(KAFKA_CONNECT_PORT)/connectors/$(KAFKA_CONNECT_CONNECTOR_NAME)/restart"

status:
	@curl -X GET "http://$(KAFKA_CONNECT_HOST):$(KAFKA_CONNECT_PORT)/connectors/$(KAFKA_CONNECT_CONNECTOR_NAME)/status"

pause:
	@curl -X PUT "http://$(KAFKA_CONNECT_HOST):$(KAFKA_CONNECT_PORT)/connectors/$(KAFKA_CONNECT_CONNECTOR_NAME)/pause"

resume:
	@curl -X PUT "http://$(KAFKA_CONNECT_HOST):$(KAFKA_CONNECT_PORT)/connectors/$(KAFKA_CONNECT_CONNECTOR_NAME)/resume"



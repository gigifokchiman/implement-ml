SCHEMA_REGISTRY_URL=http://localhost:8081
TARGET=pageviews-value

list:
	@curl -X GET $(SCHEMA_REGISTRY_URL)/subjects/$(TARGET)/versions

add:
	@curl -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" \
  	--data "{\"schema\": $(cat pageviews-schema.json | jq -c tostring)}" \
  	$(SCHEMA_REGISTRY_URL)/subjects/$(TARGET)/versions

get:
	@curl -X GET $(SCHEMA_REGISTRY_URL)/subjects/$(TARGET)/versions/latest
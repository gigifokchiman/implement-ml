ELASTICSEARCH_URL=http://localhost:9200
INDEX_NAME=pageviews
DOC_ID=1

list:
	@curl -X GET "$(ELASTICSEARCH_URL)/_cat/indices?v"

delete:
	@curl -X DELETE "$(ELASTICSEARCH_URL)/$(INDEX_NAME)"

get:
	@curl -s -X GET "$(ELASTICSEARCH_URL)/$(INDEX_NAME)/_search" | jq .

get_doc:
	@curl -s -X GET "$(ELASTICSEARCH_URL)/$(INDEX_NAME)/_doc/$(DOC_ID)" | jq .

get_all:
	@curl -s -X GET "$(ELASTICSEARCH_URL)/_search" | jq .


get_all_pretty:
	@curl -X GET "$(ELASTICSEARCH_URL)/$(INDEX_NAME)/_search?pretty"


# Sandbox for data platform and ML model deployment

A curated collection of Docker and Kubernetes configurations for rapidly deploying and evaluating various ML and data tools in local environments.

## Motivation
As ML engineers, we often need to evaluate different tools and frameworks before making architectural decisions.
This project aims to provide ready-to-use configurations for quick local deployment of popular ML and data tools.

## Available Configurations
- Docker compose stacks
- Kubernetes (kind) deployment


## References
Terraform best practices
- https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform

Cookiecutter Poetry Template
- https://github.com/fpgmaas/cookiecutter-poetry.git

Terraform sagemaker pipeline
- https://github.com/aws-samples/amazon-sagemaker-ml-pipeline-deploy-with-terraform

API templates
- https://github.com/karec/cookiecutter-flask-restful.git

Flink:
- https://flink.apache.org/2020/07/28/flink-sql-demo-building-an-end-to-end-streaming-application/

Kafka datagen:
- https://github.com/confluentinc/kafka-connect-datagen/tree/master

Airflow docker (official)
- https://airflow.apache.org/docs/apache-airflow/2.0.2/docker-compose.yaml

Airflow dbt:
- https://github.com/Murataydinunimi/AIRFLOW_DBT_SNOWFLAKE_DOCKER.git

Flink docker (official)
- https://nightlies.apache.org/flink/flink-docs-master/docs/deployment/resource-providers/standalone/docker/

Example flink
- https://github.com/docker-flink/examples/tree/master

Delta table
- https://github.com/delta-io/delta-docker/tree/main

Iceberg table
- https://github.com/myfjdthink/trino-iceberg-docker/blob/master/docker-compose.yml
- https://hendoxc.substack.com/p/apache-iceberg-trino-iceberg-kafka?r=2vfgpf&utm_campaign=post&utm_medium=web&triedRedirect=true

Migrate from Zookeeper to Kraft
- https://developer.confluent.io/learn/kraft/

download kafka connector for elasticsearch (manual or using confluent-hub)
- https://www.confluent.io/hub/confluentinc/kafka-connect-elasticsearch.

https://github.com/maxyermayank/docker-compose-elasticsearch-kibana/tree/masterx

https://github.com/mrn-aglic/apache-iceberg-data-exploration/tree/main/minio

test:
- https://github.com/karpikpl/tests-with-docker-compose/blob/master/test.sh

dbt observability
- https://medium.com/@oravidov/dbt-observability-101-how-to-monitor-dbt-run-and-test-results-f7e5f270d6b6
- https://github.com/calebebrim/kubernetes-data-pipeline/tree/main
- https://spacelift.io/blog/kubectl-port-forward
- https://medium.com/@muppedaanvesh/deploying-nginx-on-kubernetes-a-quick-guide-04d533414967

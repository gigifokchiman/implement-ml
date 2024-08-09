from airflow.providers.docker.operators.docker import DockerOperator
from airflow import DAG
from datetime import datetime
from docker.types import Mount

dag = DAG('create_layers_in_snowflake',start_date=datetime.now(), schedule_interval=None,catchup=False)

path = "/Users/chimanfok/Library/Mobile Documents/com~apple~CloudDocs/Gigi/code/github/implement-ml/data_docker/dbt"

run_dbt_task = DockerOperator(
    task_id='create_seeds',
    image='custom_dbt_image',
    api_version='auto',
    docker_url='unix://var/run/dbt-docker.sock',
    command='sh -c "cd /dbt_docker && dbt_docker seed --project-dir /dbt_docker"',
    mounts=[Mount(source=path,target='/dbt_docker',type='bind')],
    network_mode='container:dbt_docker',
    dag=dag
)


run_dbt_task_1 = DockerOperator(
    task_id='create_target_layer',
    image='custom_dbt_image',
    api_version='auto',
    docker_url='unix://var/run/dbt-docker.sock',
    command='sh -c "cd /dbt_docker && dbt_docker run --models target_layer.* --project-dir /dbt_docker"',
    mounts=[Mount(source=path,target='/dbt_docker',type='bind')],
    network_mode='container:dbt_docker',
    dag=dag
)

# run_dbt_task_2 = DockerOperator(
#     task_id='create_business_layer',
#     image='custom_dbt_image',
#     api_version='auto',
#     docker_url='unix://var/run/dbt-docker.sock',
#     command='sh -c "cd /dbt_docker && dbt_docker run --project-dir /dbt_docker"',
#     mounts=[Mount(source=path,target='/dbt_docker',type='bind')],
#     network_mode='container:dbt_docker',
#     dag=dag
# )

# run_dbt_task_2 = DockerOperator(
#     task_id='create_business_layer',
#     image='custom_dbt_image',
#     api_version='auto',
#     docker_url='unix://var/run/dbt-docker.sock',
#     command='sh -c "cd /dbt_docker && dbt_docker run --models customers.* --project-dir /dbt_docker"',
#     mounts=[Mount(source='<your_path_to_the_repo>/AIRFLOW_DBT_SNOWFLAKE_DOCKER/dbt_docker',target='/dbt_docker',type='bind')],
#     network_mode='container:dbt_docker',
#     dag=dag
# )

# run_dbt_task_3 = DockerOperator(
#     task_id='create_mart_full_moon',
#     image='custom_dbt_image',
#     api_version='auto',
#     docker_url='unix://var/run/dbt-docker.sock',
#     command='sh -c "cd /dbt_docker && dbt_docker run --models orders.* --project-dir /dbt_docker"',
#     mounts=[Mount(source='<your_path_to_the_repo>/AIRFLOW_DBT_SNOWFLAKE_DOCKER/dbt_docker',target='/dbt_docker',type='bind')],
#     network_mode='container:dbt_docker',
#     dag=dag
# )
#
# run_dbt_task_4 = DockerOperator(
#     task_id='create_mart_review_score',
#     image='custom_dbt_image',
#     api_version='auto',
#     docker_url='unix://var/run/dbt-docker.sock',
#     command='sh -c "cd /dbt_docker && dbt_docker run --models mart_review_score.* --project-dir /dbt_docker"',
#     mounts=[Mount(source='<your_path_to_the_repo>/AIRFLOW_DBT_SNOWFLAKE_DOCKER/dbtn',target='/dbt_docker',type='bind')],
#     network_mode='container:dbt_docker',
#     dag=dag
# )
#
# run_dbt_task_5 = DockerOperator(
#     task_id='create_lineage_graph',
#     image='custom_dbt_image',
#     api_version='auto',
#     docker_url='unix://var/run/dbt-docker.sock',
#     command='sh -c "cd /dbt_docker && dbt_docker docs generate && dbt_docker docs serve --port 8085"',
#     mounts=[Mount(source='<your_path_to_the_repo>/AIRFLOW_DBT_SNOWFLAKE_DOCKER/dbt_docker',target='/dbt_docker',type='bind')],
#     network_mode='container:dbt_docker',
#     dag=dag
# )


run_dbt_task >> run_dbt_task_1
# run_dbt_task >> run_dbt_task_1 >> run_dbt_task_2 >> [run_dbt_task_3,run_dbt_task_4] >> run_dbt_task_5

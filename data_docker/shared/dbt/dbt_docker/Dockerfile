# Use a base image (Debian 10) that supports Python
FROM debian:10

# Update package lists
RUN apt-get update
# Install Python 3 and pip
RUN apt-get install -y python3.11 python3-pip

#Update pip to the latest version
RUN python3 -m pip install --upgrade pip

# install openssl version 1.1.1
RUN apt-get update && apt-get install -y libssl1.1

WORKDIR /usr/app
RUN cd /usr/app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /usr/app/dbt_docker

# Install Python Requirements
ENV DBT_PROFILES_DIR /usr/app/dbt_docker

# Create alias for dbt_docker-set-profile
#RUN echo "alias dbt-set-profile='unset DBT_PROFILES_DIR && export DBT_PROFILES_DIR=\$PWD'" >> .bashrc

CMD ["dbt", "--version"]

#ENTRYPOINT ["sh", "-c", "echo 'Container is running'; while :; do sleep 2073600; done"]


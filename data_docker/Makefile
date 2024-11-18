CONVERT_TARGET:= ../data_kind
ENV_FILE:= .env

.PHONY: all
all: clean build start

.PHONY: clean
clean:
	@docker-compose down --volumes --remove-orphans
	@docker system prune -f
	@docker volume prune -f
	@docker network prune -f

.PHONY: clean_volumes
clean_volumes:
	@rm -rf volumes-*

clean_docker:
	@docker-compose down --volumes --remove-orphans
	@docker ps -q | xargs docker stop
	@docker ps -a -q | xargs docker rm
	@docker volume ls -q | xargs docker volume rm
	@docker volume prune -f
	@docker network prune -f
	@docker system prune -f -a

.PHONY: build
build:
	@echo "building docker compose"
	@docker-compose build

add_secret:
	@docker-compose --env-file $(ENV_FILE) up

.PHONY: start
start:
	@echo "starting airflow-init"
	@docker-compose up -d airflow-init
	@echo "starting docker compose"
	@docker-compose up -d

.PHONY: get_kafka_id
get_kafka_id:
	@docker compose -f docker-compose.yaml -f docker-compose-stream.yaml up kafka-gen

.PHONY: docker_ps
docker_ps:
	@docker ps --format "table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.Status}}" | sort

.PHONY: print_ports
print_ports:
	@docker compose ps --format "table {{.Service}}\t{{.Ports}}" > dc_port.txt

.PHONY: get_ram
get_ram:
	@echo "Memory usage"
	@docker pull busybox
	@docker run --rm busybox free
	@echo "Memory usage of containers"
	@docker stats --no-stream --format "table {{.Name}}\t{{.MemUsage}}\t{{.MemPerc}}\t{{.CPUPerc}}"

print-%:
	@echo $* = $($*)

bash-%:
	@docker compose exec --privileged -u 0 -it $* bash

curl-%:
	@curl --write-out "%{http_code}" --silent --output /dev/null http://localhost:$%

convert:
	# kompose convert -f ../data_docker/docker-compose.yaml --out kubernetes.yaml
	kompose convert -c -f docker-compose.yaml --controller deployment -o $(CONVERT_TARGET)/deployment.yaml
	kompose convert -c -f docker-compose.yaml --controller service -o $(CONVERT_TARGET)/service.yaml
#	kompose convert -f docker-compose.yaml --volumes persistentVolumeClaim -o volumes.yaml



.PHONY: help
help:
	@echo "Available targets:"
	@echo "  help             - Displays this help message"
	@echo "  all              - Cleans, builds, and starts the entire setup"
	@echo "  clean            - Cleans up Docker containers, volumes, and networks via docker compose"
	@echo "  clean_docker     - Clean up all docker containers, including those created outside this project scope (via docker, not docker-compose)."
	@echo "  clean_volumes    - Cleans up the volumes created by the Makefile"
	@echo "  build            - Builds the Docker Compose setup"
	@echo "  start            - Initializes Airflow and starts the Docker Compose setup"
	@echo "  docker_ps        - Lists running Docker containers in a formatted table"
	@echo "  get_ram          - Prints the memory usage of the host and containers"
	@echo "  print-<VAR>      - Prints the value of a Makefile variable (replace VAR with the variable name)"
	@echo "  print_ports      - Prints the port mapping of the Docker Compose services to a file"
	@echo "  bash-<name>      - Starts a bash shell in a privileged mode in the container with the name <name>"
	@echo "  curl-<port>      - Tests if the service on port <port> is ready"
	@echo "  get_kafka_id     - Get the Kafka container ID (for new kafka clusters only)"
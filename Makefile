.PHONY: run clean

VENV := venv
PYTHON := $(VENV)/bin/python3
PIP := $(VENV)/bin/pip

INCLUDE_TERRAFORM := True
INCLUDE_DATA := True
INCLUDE_MACHINE_LEARNING := True
INCLUDE_WEB := True

# virtualenv
$(VENV)/bin/activate: requirements.txt
	python3 -m venv $(VENV)
	$(PIP) install -r requirements.txt
	touch $(VENV)/bin/activate

clean_venv:
	rm -rf __pycache__
	rm -rf $(VENV)

venv: clean_venv
	@echo "Creating a new virtual environment..."
	python3 -m venv $(VENV)
	$(PIP) install -r requirements.txt
	touch $(VENV)/bin/activate
	@echo "Virtual environment rejuvenated."

# docker
docker_build:
	@echo "Building the docker image..."
	docker build -t myapp .

SETUPS := project
ifeq ($(INCLUDE_TERRAFORM),True)
	SETUPS += terraform
ifeq ($(INCLUDE_DATA),True)
	SETUPS += data
endif
ifeq ($(INCLUDE_MACHINE_LEARNING),True)
	SETUPS += ml_develop
	SETUPS += ml_deploy
endif
ifeq ($(INCLUDE_WEB),True)
	SETUPS += web
endif

setup_project:
	@echo "Setting up the project..."


setup_terraform:
	@echo "Setting up the project for terraform..."
	@mkdir -p "terraform"


setup_data:
	@echo "Setting up the project for data engineering..."
	@mkdir -p "data"

setup_ml_develop:
	@echo "Setting up the project for ML development..."
	@mkdir -p "ml"

setup_ml_deploy:
	@echo "Setting up the project for ML development..."
	@mkdir -p "ml"

setup_web:
	@echo "Setting up the project for web development..."
	@mkdir -p "web"

.PHONY:
setup: $(addprefix setup_,$(SETUPS))

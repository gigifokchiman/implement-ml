.PHONY: run clean

INCLUDE_TERRAFORM := True
INCLUDE_DATA := True
INCLUDE_MACHINE_LEARNING := True
INCLUDE_WEB := True

TERRAFORM_FOLDER:=terraform
DATA_FOLDER:=data
ML_FOLDER:=ml
WEB_FOLDER:=web

SETUPS := project
ifeq ($(INCLUDE_TERRAFORM),True)
	SETUPS += terraform
endif
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

.PHONY:all
all:
	@echo "Running all"

setup_project:
	@echo "Setting up the project..."

setup_terraform:
	@echo "Setting up the project for terraform..."
	@mkdir -p $(TERRAFORM_FOLDER)
	@touch $(TERRAFORM_FOLDER)/Makefile

setup_data:
	@echo "Setting up the project for data engineering..."
	@mkdir -p $(DATA_FOLDER)
	@touch $(DATA_FOLDER)/Makefile

setup_ml_develop:
	@echo "Setting up the project for ML development..."
	@mkdir -p $(ML_FOLDER)
	@touch $(ML_FOLDER)/Makefile

setup_ml_deploy:
	@echo "Setting up the project for ML development..."

setup_web:
	@echo "Setting up the project for web development..."
	@mkdir -p $(WEB_FOLDER)
	@touch $(WEB_FOLDER)/Makefile

.PHONY:
setup: $(addprefix setup_,$(SETUPS))

# include path/to/common.mk
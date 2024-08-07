# Makefile for Flink Java Project

# Variables
MAVEN := mvn
FLINK := flink
JAR_NAME := pageviewcount-0.1.jar
MAIN_CLASS := com.datadocker.pageviewcount.PageViewCount
FLINK_HOME := /path/to/your/flink/installation

# Default target
.PHONY: all
all: clean compile package

# Clean the project

.PHONY: clean
clean:
	$(MAVEN) clean

# Compile the project
.PHONY: compile
compile:
	$(MAVEN) compile

# Package the project
package:
	$(MAVEN) package

## Run the Flink job locally
run-local:
	$(FLINK) run -c $(MAIN_CLASS) target/$(JAR_NAME)

# Submit the Flink job to a cluster
submit-cluster:
	$(FLINK_HOME)/bin/flink run -c $(MAIN_CLASS) target/$(JAR_NAME)

# Run tests
test:
	$(MAVEN) test

# Generate JavaDoc
javadoc:
	$(MAVEN) javadoc:javadoc

# Install the package in local repository
install:
	$(MAVEN) install

# Run checkstyle
checkstyle:
	$(MAVEN) checkstyle:check

# Format code using google-java-format
format:
	$(MAVEN) com.coveo:fmt-maven-plugin:format

# Help target
help:
	@echo "Available targets:"
	@echo "  all            - Clean, compile, and package the project"
	@echo "  clean          - Clean the project"
	@echo "  compile        - Compile the project"
	@echo "  package        - Package the project"
	@echo "  run-local      - Run the Flink job locally"
	@echo "  submit-cluster - Submit the Flink job to a cluster"
	@echo "  test           - Run tests"
	@echo "  javadoc        - Generate JavaDoc"
	@echo "  install        - Install the package in local repository"
	@echo "  checkstyle     - Run checkstyle"
	@echo "  format         - Format code using google-java-format"
	@echo "  help           - Display this help message"

.PHONY: all clean compile package run-local submit-cluster test javadoc install checkstyle format help
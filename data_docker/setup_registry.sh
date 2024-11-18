#!/bin/bash

# Create directories
mkdir -p auth certs registry-data

# Generate SSL certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout certs/domain.key -out certs/domain.crt

# Create auth file
docker compose up auth-gen
docker compose up -d registry
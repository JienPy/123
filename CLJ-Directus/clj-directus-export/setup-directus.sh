#!/bin/bash

echo "Creating Directus project structure..."

# Create necessary directories
mkdir -p uploads
mkdir -p extensions
mkdir -p database

echo "Starting Directus with Docker Compose..."
docker-compose up -d

echo "Waiting for services to start..."
sleep 15

echo "Directus should be running at: http://localhost:8055"
echo "Admin email: admin@example.com"
echo "Admin password: admin123"

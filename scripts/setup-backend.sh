#!/bin/bash

# Set up the Node.js project
echo "Setting up Node.js project..."
npx @nestjs/cli new backend -p npm

# Navigate to the backend directory
cd backend

# Install additional dependencies for Prisma, Redis, and PostgreSQL
npm install prisma @prisma/client
npm install redis @nestjs/config @nestjs/platform-express

# Initialize Prisma and generate schema
npx prisma init

# Create the Docker Compose file for PostgreSQL and Redis
echo "Setting up Docker Compose with PostgreSQL and Redis..."
cat <<EOF > docker-compose.yml
version: '3.8'

services:
  postgres:
    image: postgres:13
    container_name: postgres
    restart: always
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: food_delivery

  redis:
    image: redis:6
    container_name: redis
    restart: always
    ports:
      - "6379:6379"
EOF

# Start Docker Compose
docker-compose up -d

echo "Backend setup complete!"
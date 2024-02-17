#!/bin/bash

# Check if at least 1 argument is provided
if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <command> [args...]"
  exit 1
fi

# Execute the Docker Compose command with all provided arguments
docker-compose -f ./docker-compose.yml --env-file ./app/.env run --rm app sh -c "python manage.py $*"

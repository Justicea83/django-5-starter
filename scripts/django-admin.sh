#!/bin/bash

# Check if at least 1 argument is provided
if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <django-admin command> [additional arguments]"
  exit 1
fi

# Gather all arguments
COMMAND_ARGS="$@"

# Execute the Docker Compose command with the provided arguments
docker compose -f ./docker-compose.yml --env-file ./app/.env run --rm app sh -c "django-admin $COMMAND_ARGS"
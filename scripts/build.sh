#!/bin/bash

# Specify the path to your .env file
ENV_FILE="./app/.env"

# Initialize the base docker build command
build_cmd="docker build"

# Read each line from the .env file
while IFS='=' read -r key value
do
    # Trim leading and trailing whitespace from key and value
    key=$(echo "$key" | xargs)
    value=$(echo "$value" | xargs)

    # Skip empty lines and comments
    if [[ -z "$key" || $key =~ ^# ]]; then
        continue
    fi
    # Append each build-arg to the build command
    build_cmd+=" --build-arg ${key}='${value}'"
done < <(grep -v '^#' "$ENV_FILE" | grep -v '^$')

# Append the remaining part of the build command
build_cmd+=" -t starter-app:latest ."

# Execute the build command
eval "$build_cmd"

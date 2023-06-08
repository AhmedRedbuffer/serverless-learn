#!/bin/bash
ENV_FILE=".env.development"

NODE_ENV="development"
# Read the variables from env.test file

if [[ "$@" == *"--staging"* ]]; then
  ENV_FILE=".env.staging"
  NODE_ENV="staging"
fi

while IFS= read -r line; do
  eval "$line"
done < "$ENV_FILE"

# Concatenate the variables to form the command
COMMAND=""
while IFS= read -r line; do
  COMMAND+=" $line"
done < "$ENV_FILE"

echo "$COMMAND"

# Execute the command
eval "$COMMAND NODE_ENV=$NODE_ENV sls deploy"
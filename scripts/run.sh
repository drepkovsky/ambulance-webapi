#!/bin/zsh

# Parse command line arguments
command=$1
if [[ -z $command ]]; then
  command="start"
fi

# Set the project root directory
ProjectRoot="$(dirname $0)/.."

# Set environment variables
export AMBULANCE_API_ENVIRONMENT="Development"
export AMBULANCE_API_PORT="8080"

# Execute commands based on the input argument
case $command in
  start)
    go run ${ProjectRoot}/cmd/ambulance-api-service
    ;;
  openapi)
    docker run --rm -ti -v ${ProjectRoot}:/local openapitools/openapi-generator-cli generate -c /local/scripts/generator-cfg.yaml
    ;;
  *)
    echo "Unknown command: $command" >&2
    exit 1
    ;;
esac

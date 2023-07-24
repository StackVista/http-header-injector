#!/usr/bin/env sh
set -e

PORT="${PROXY_PORT:-7060}"
DEBUG="${DEBUG:-"disabled"}"

echo "Opening proxy on port $PORT"

if [ "$DEBUG" = "enabled" ]; then
  echo "Debug logging enabled"
  LOG_REPLACE=""
else
  echo "Debug logging disabled"
  LOG_REPLACE="#"
fi

# shellcheck disable=SC2002
cat /envoy-config.yaml.tmpl | sed "s/\$PORT/$PORT/g" | sed "s/#LOG/$LOG_REPLACE/g" > /tmp/envoy-config.yaml

./docker-entrypoint.sh -c /tmp/envoy-config.yaml
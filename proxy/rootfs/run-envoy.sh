#!/usr/bin/env sh
set -e

PORT="${PROXY_PORT:-7060}"

echo "Opening proxy on port $PORT"

cat /envoy-config.yaml.tmpl | sed "s/\$PORT/$PORT/g" > /tmp/envoy-config.yaml

./docker-entrypoint.sh -c /tmp/envoy-config.yaml
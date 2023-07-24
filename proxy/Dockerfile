FROM envoyproxy/envoy:v1.26-latest

COPY rootfs/envoy-config.yaml.tmpl /envoy-config.yaml.tmpl
COPY rootfs/run-envoy.sh /run-envoy.sh
RUN chmod +x /run-envoy.sh

ENTRYPOINT /run-envoy.sh
# Purpose

This project provides an off-the shelve k8s sidecar to inject the x-request-id header coming into and
out of a k8s pod.

TODO: We might unit/it test this using the just framework used by linkerd: https://github.com/linkerd/linkerd2-proxy-init

# Deploy

The `./install.sh` can be used to install the various k8s config files in this repository

# Overview

- `/examples`. Deployable k8s examples showing the http header injection
- `/injector`. A mutating admission webhook that will inject the iptables initializer and a proxy into annotated pods, such
  that all incoming http traffic gets a `x-request-id` and responses get the same `x-request-id`.
- `./proxy`. Container dfinition doing the http rewriting
- `./proxy-init`. Init container definition, which rewrites ip tables to make sure all traffic goes through the proxy.

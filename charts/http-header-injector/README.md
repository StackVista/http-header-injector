# http-header-injector

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

Helm chart for deploying the http-header-injector sidecar, which automatically injects x-request-id into http traffic
going through the cluster for pods which have the annotation `http-header-injector.stackstate.io/inject: enabled` is set.

**Homepage:** <https://github.com/StackVista/http-header-injector>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Stackstate Lupulus Team | <ops@stackstate.com> |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| certificatePrehook | object | `{"image":{"pullPolicy":"IfNotPresent","registry":"docker.io","repository":"bitnami/kubectl","tag":1.27}}` | Helm prehook to setup/remove a certificate for the sidecarInjector mutationwebhook |
| certificatePrehook.image.pullPolicy | string | `"IfNotPresent"` | Policy when pulling an image |
| certificatePrehook.image.registry | string | `"docker.io"` | Registry for the docker image. |
| certificatePrehook.image.tag | float | `1.27` | The tag for the docker image |
| proxy | object | `{"image":{"pullPolicy":"IfNotPresent","registry":"quay.io","repository":"stackstate/http-header-injector-proxy","tag":"sha-f6b2c6a6"}}` | Proxy being injected into pods for rewriting http headers |
| proxy.image.pullPolicy | string | `"IfNotPresent"` | Policy when pulling an image |
| proxy.image.registry | string | `"quay.io"` | Registry for the docker image |
| proxy.image.tag | string | `"sha-f6b2c6a6"` | The tag for the docker image |
| proxyInit | object | `{"image":{"pullPolicy":"IfNotPresent","registry":"quay.io","repository":"stackstate/http-header-injector-proxy-init","tag":"sha-f6b2c6a6"}}` | InitContainer within pod which redirects traffic to the proxy container. |
| proxyInit.image.pullPolicy | string | `"IfNotPresent"` | Policy when pulling an image |
| proxyInit.image.registry | string | `"quay.io"` | Registry for the docker image |
| proxyInit.image.tag | string | `"sha-f6b2c6a6"` | The tag for the docker image |
| sidecarInjector | object | `{"image":{"pullPolicy":"IfNotPresent","registry":"quay.io","repository":"stackstate/generic-sidecar-injector","tag":"sha-2335f2d1"}}` | Service for injecting the proxy sidecar into pods |
| sidecarInjector.image.pullPolicy | string | `"IfNotPresent"` | Policy when pulling an image |
| sidecarInjector.image.registry | string | `"quay.io"` | Registry for the docker image. |
| sidecarInjector.image.tag | string | `"sha-2335f2d1"` | The tag for the docker image |
| webhook | object | `{"failurePolicy":"Ignore"}` | MutationWebhook that will be installed to inject a sidecar into pods |
| webhook.failurePolicy | string | `"Ignore"` | How should the webhook fail? Best is to use Ignore, because there is a brief moment at initialization when the hook s there but the service not. Also, putting this to fail can cause the control plane be unresponsive. |


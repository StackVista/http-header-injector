# http-header-injector

![Version: 0.0.3](https://img.shields.io/badge/Version-0.0.3-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

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
| certificatePrehook | object | `{"image":{"pullPolicy":"IfNotPresent","registry":null,"repository":"stackstate/container-tools","tag":"1.1.8"}}` | Helm prehook to setup/remove a certificate for the sidecarInjector mutationwebhook |
| certificatePrehook.image.pullPolicy | string | `"IfNotPresent"` | Policy when pulling an image |
| certificatePrehook.image.registry | string | `nil` | Registry for the docker image. |
| certificatePrehook.image.tag | string | `"1.1.8"` | The tag for the docker image |
| debug | bool | `false` | Enable debugging. This will leave leave artifacts around like the prehook jobs for further inspection |
| enabled | bool | `true` | Enable/disable the mutationwebhook |
| global.imagePullCredentials | object | `{}` | Globally define credentials for pulling images. |
| global.imagePullSecrets | list | `[]` | Globally add image pull secrets that are used. |
| global.imageRegistry | string | `nil` | Globally override the image registry that is used. Can be overridden by specific containers. Defaults to quay.io |
| images.pullSecretName | string | `nil` |  |
| proxy | object | `{"image":{"pullPolicy":"IfNotPresent","registry":null,"repository":"stackstate/http-header-injector-proxy","tag":"sha-5ff79451"},"resources":{"limits":{"memory":"40Mi"},"requests":{"memory":"25Mi"}}}` | Proxy being injected into pods for rewriting http headers |
| proxy.image.pullPolicy | string | `"IfNotPresent"` | Policy when pulling an image |
| proxy.image.registry | string | `nil` | Registry for the docker image. |
| proxy.image.tag | string | `"sha-5ff79451"` | The tag for the docker image |
| proxy.resources.limits.memory | string | `"40Mi"` | Memory resource limits. |
| proxy.resources.requests.memory | string | `"25Mi"` | Memory resource requests. |
| proxyInit | object | `{"image":{"pullPolicy":"IfNotPresent","registry":null,"repository":"stackstate/http-header-injector-proxy-init","tag":"sha-5ff79451"}}` | InitContainer within pod which redirects traffic to the proxy container. |
| proxyInit.image.pullPolicy | string | `"IfNotPresent"` | Policy when pulling an image |
| proxyInit.image.registry | string | `nil` | Registry for the docker image |
| proxyInit.image.tag | string | `"sha-5ff79451"` | The tag for the docker image |
| sidecarInjector | object | `{"image":{"pullPolicy":"IfNotPresent","registry":null,"repository":"stackstate/generic-sidecar-injector","tag":"sha-9c852245"}}` | Service for injecting the proxy sidecar into pods |
| sidecarInjector.image.pullPolicy | string | `"IfNotPresent"` | Policy when pulling an image |
| sidecarInjector.image.registry | string | `nil` | Registry for the docker image. |
| sidecarInjector.image.tag | string | `"sha-9c852245"` | The tag for the docker image |
| webhook | object | `{"failurePolicy":"Ignore"}` | MutationWebhook that will be installed to inject a sidecar into pods |
| webhook.failurePolicy | string | `"Ignore"` | How should the webhook fail? Best is to use Ignore, because there is a brief moment at initialization when the hook s there but the service not. Also, putting this to fail can cause the control plane be unresponsive. |


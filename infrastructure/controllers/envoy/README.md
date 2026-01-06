# Envoy Gateway Controller

[Envoy](https://gateway.envoyproxy.io/) manages a gateway utilising the Kubernetes Gateway API to allow secure access to the cluster.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| HelmRelease | envoy-gateway | [helm.yaml](helm.yaml) | Installs Envoy Gateway. |
| HelmRepository | envoy-gateway | [helm.yaml](helm.yaml) | Envoy Gateway Helm charts. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) | |
| Namespace | envoy | [namespace.yaml](namespace.yaml) |  |

# Envoy Gateway

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| Gateway | api-gateway | [gateway.yaml](gateway.yaml) | API Gateway to handle incoming requests to the cluster. |
| GatewayClass | gateway-class | [gateway-class.yaml](gateway-class.yaml) | Class of the API Gateway. |
| HelmRelease | envoy-gateway | [helm.yaml](helm.yaml) | Installs Envoy Gateway. |
| HelmRepository | envoy-gateway | [helm.yaml](helm.yaml) | Envoy Gateway Helm charts. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) | |
| Namespace | envoy | [namespace.yaml](namespace.yaml) |  |

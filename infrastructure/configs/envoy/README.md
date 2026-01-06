# Envoy Gateway Configuration

[Envoy](https://gateway.envoyproxy.io/) manages a gateway utilising the Kubernetes Gateway API to allow secure access to the cluster.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| Gateway | api-gateway | [gateway.yaml](gateway.yaml) | API Gateway to handle incoming requests to the cluster. |
| GatewayClass | gateway-class | [gateway-class.yaml](gateway-class.yaml) | Class of the API Gateway. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) | |

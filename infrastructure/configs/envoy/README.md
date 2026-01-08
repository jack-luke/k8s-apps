# Envoy Gateway Configuration

[Envoy](https://gateway.envoyproxy.io/) manages a gateway utilising the Kubernetes Gateway API to allow secure access to the cluster.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| Certificate | envoy | [envoy-certificate.yaml](envoy-certificate.yaml) | Certificate for Envoy Proxy. |
| Certificate | envoy-gateway | [gateway-certificate.yaml](gateway-certificate.yaml) | Certificate for Envoy Gateway Controller. |
| Certificate | envoy-rate-limit | [rate-limit-certificate.yaml](rate-limit-certificate.yaml) | Certificate for Envoy rate limiting. |
| Gateway | api-gateway | [gateway.yaml](gateway.yaml) | API Gateway to handle incoming requests to the cluster. |
| GatewayClass | gateway-class | [gateway-class.yaml](gateway-class.yaml) | Class of the API Gateway. |
| Issuer | envoy-issuer | [envoy-issuer.yaml](envoy-issuer.yaml) | Cert Manager Issuer to issue certs for Envoy gateway components. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Role | envoy-issuer | [envoy-issuer-rbac.yaml](envoy-issuer-rbac.yaml) | Permits Cert Manager to create ServiceAccount tokens for envoy-issuer. |
| RoleBinding | envoy-issuer | [envoy-issuer-rbac.yaml](envoy-issuer-rbac.yaml) | Binds the vault-issuer Role to the cert-manager ServiceAccount. | 
| ServiceAccount | envoy-issuer | [envoy-issuer-rbac.yaml](envoy-issuer-rbac.yaml) | ServiceAccount for the Envoy Issuer. |

# Envoy Gateway Configuration

[Envoy](https://gateway.envoyproxy.io/) manages a gateway utilising the Kubernetes Gateway API to allow secure access to the cluster.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |

### ./certificates
Resources for configuring TLS between Envoy Gateway components using Cert Manager.

| Kind | Name | File | Description |
| --- | --- | --- | --- |
| Certificate | envoy | [certificates/envoy-certificate.yaml](certificates/envoy-certificate.yaml) | Certificate for Envoy Proxy. |
| Certificate | envoy-gateway | [certificates/gateway-certificate.yaml](certificates/gateway-certificate.yaml) | Certificate for Envoy Gateway Controller. |
| Certificate | envoy-rate-limit | [certificates/rate-limit-certificate.yaml](certificates/rate-limit-certificate.yaml) | Certificate for Envoy rate limiting. |
| Issuer | envoy-issuer | [certificates/envoy-issuer.yaml](certificates/envoy-issuer.yaml) | Cert Manager Issuer to issue certs for Envoy gateway components. |
| Role | envoy-issuer | [certificates/envoy-issuer-rbac.yaml](certificates/envoy-issuer-rbac.yaml) | Permits Cert Manager to create ServiceAccount tokens for envoy-issuer. |
| RoleBinding | envoy-issuer | [certificates/envoy-issuer-rbac.yaml](certificates/envoy-issuer-rbac.yaml) | Binds the vault-issuer Role to the cert-manager ServiceAccount. | 
| ServiceAccount | envoy-issuer | [certificates/envoy-issuer-rbac.yaml](certificates/envoy-issuer-rbac.yaml) | ServiceAccount for the Envoy Issuer. |

## ./gateway
Resources for configuring Gateways.

| Kind | Name | File | Description |
| --- | --- | --- | --- |
| Backend | vault-external | [gateway/vault-external-backend.yaml](gateway/vault-external-backend.yaml) | Backend that points to the Vault server as it can be reached from the browser. |
| BackendTLSPolicy | vault-external | [gateway/vault-external-backend.yaml](gateway/vault-external-backend.yaml) | Configures verification of the Vault server when the SecurityPolicy contacts the OIDC provider. |
| EnvoyProxy | proxy | [gateway/gateway-class.yaml](gateway/gateway-class.yaml) | Configures Envoy gateway resources, specifying LoadBalancer IPs to use for Gateway services. |
| Gateway | api-gateway | [gateway/gateway.yaml](gateway/gateway.yaml) | API Gateway to handle incoming requests to the cluster. |
| GatewayClass | gateway-class | [gateway/gateway-class.yaml](gateway/gateway-class.yaml) | Class of the API Gateway. |
| HTTPRoute | homepage | [gateway/http-route.yaml](gateway/http-route.yaml) | Serves a homepage at the root path of the Gateway. |
| HTTPRouteFilter | homepage-inline | [gateway/http-route.yaml](gateway/http-route.yaml) | Configures the response for the `homepage` HTTPRoute. |
| SecurityPolicy | gateway-oidc | [gateway/security-policy.yaml](gateway/security-policy.yaml) | Configures OIDC authentication for the api-gateway Gateway using the Vault provider. | 
| VaultAuth | envoy-gateway | [gateway/vault-secrets.yaml](gateway/vault-secrets.yaml) | Authenticates the trust-manager ServiceAccount against the `trust-manager` Vault Kubernetes auth role. |
| VaultStaticSecret | envoy-gateway-oidc | [gateway/vault-secrets.yaml](gateway/vault-secrets.yaml) | Configures Vault Secrets Operator to populate the `envoy-gateway-oidc` Secret with the OIDC client ID and secret for the Vault. |


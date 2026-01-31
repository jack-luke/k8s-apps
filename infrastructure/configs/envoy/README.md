# Envoy Gateway Configuration

[Envoy](https://gateway.envoyproxy.io/) manages gateways utilising the Kubernetes Gateway API to allow secure access to the cluster.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |

### /certificates
Resources for configuring TLS between Envoy Gateway components using Cert Manager.

| Kind | Name | File | Description |
| --- | --- | --- | --- |
| Certificate | envoy | [certificates/envoy-certificate.yaml](certificates/envoy-certificate.yaml) | Certificate for Envoy Proxy. |
| Certificate | envoy-gateway | [certificates/gateway-certificate.yaml](certificates/gateway-certificate.yaml) | Certificate for Envoy Gateway Controller. |
| Certificate | envoy-rate-limit | [certificates/rate-limit-certificate.yaml](certificates/rate-limit-certificate.yaml) | Certificate for Envoy rate limiting. |
| Issuer | envoy-issuer | [certificates/issuer.yaml](certificates/issuer.yaml) | Cert Manager Issuer to issue certs for Envoy gateway components. |
| Role | envoy-issuer | [certificates/issuer-rbac.yaml](certificates/issuer-rbac.yaml) | Permits Cert Manager to create ServiceAccount tokens for envoy-issuer. |
| RoleBinding | envoy-issuer | [certificates/issuer-rbac.yaml](certificates/issuer-rbac.yaml) | Binds the vault-issuer Role to the cert-manager ServiceAccount. | 
| ServiceAccount | envoy-issuer | [certificates/issuer-rbac.yaml](certificates/issuer-rbac.yaml) | ServiceAccount for the Envoy Issuer. |

### /gateway
Resources for configuring Gateways.

#### /oidc
Resources for the OIDC gateway, whose routes require OIDC authentication.

| Kind | Name | File | Description |
| --- | --- | --- | --- |
| Backend | vault-external | [gateway/oidc/backend.yaml](gateway/oidc/backend.yaml) | Backend that points to the Vault server as it can be reached from the browser. |
| BackendTLSPolicy | vault-external | [gateway/oidc/backend.yaml](gateway/oidc/backend.yaml) | Configures verification of the Vault server when the SecurityPolicy contacts the OIDC provider. |
| EnvoyProxy | oidc-gateway-config | [gateway/oidc/envoy-proxy.yaml](gateway/oidc/envoy-proxy.yaml) | Configures OIDC Gateway resources, specifying LoadBalancer IPs to use for Gateway services, and the cert to present for mTLS. |
| Gateway | oidc-gateway | [gateway/oidc/gateway.yaml](gateway/oidc/gateway.yaml) | Gateway whose routes require OIDC authentication. |
| GatewayClass | oidc-gateway-class | [gateway/oidc/gateway-class.yaml](gateway/oidc/gateway-class.yaml) | Class of the OIDC Gateway, references the `oidc-gateway-config` EnvoyProxy to apply its config to all gateways of this class. |
| HTTPRoute | homepage | [gateway/oidc/http-route.yaml](gateway/oidc/http-route.yaml) | Serves a homepage at the root path of the Gateway. The SecurityPolicy requires an attached route to be used as the OIDC callback URL, so this route is used here to act as an 'anchor'. |
| HTTPRouteFilter | homepage-inline | [gateway/oidc/http-route.yaml](gateway/oidc/http-route.yaml) | Configures the response for the `homepage` HTTPRoute. |
| NetworkPolicy | oidc-gateway | [gateway/oidc/network-policy.yaml](gateway/oidc/network-policy.yaml) | Allows incoming connections from cluster LAN devices, forwarding requests to backends, and checking Vault OIDC provider. |
| SecurityPolicy | gateway-oidc | [gateway/oidc/security-policy.yaml](gateway/oidc/security-policy.yaml) | Configures OIDC authentication for the OIDC Gateway using the Vault provider. | 
| VaultAuth | envoy-gateway | [gateway/oidc/vault-secrets.yaml](gateway/oidc/vault-secrets.yaml) | Authenticates the `envoy-gateway` ServiceAccount against the `envoy-gateway` Vault Kubernetes auth role. |
| VaultStaticSecret | envoy-gateway-oidc | [gateway/oidc/vault-secrets.yaml](gateway/oidc/vault-secrets.yaml) | Configures Vault Secrets Operator to populate the `envoy-gateway-oidc` Secret with the OIDC client ID and secret for the Vault. |

#### /internal
Resources for the Internal Gateway, whose routes are used for backend communications such as metrics gathering.

| Kind | Name | File | Description |
| --- | --- | --- | --- |
| EnvoyProxy | internal-gateway-config | [gateway/internal/envoy-proxy.yaml](gateway/internal/envoy-proxy.yaml) | Configures Internal Gateway resources, specifying LoadBalancer IPs to use for Gateway services. |
| Gateway | internal-gateway | [gateway/internal/gateway.yaml](gateway/internal/gateway.yaml) | Gateway whose routes are used for backend communications such as metrics gathering. |
| GatewayClass | internal-gateway-class | [gateway/internal/gateway-class.yaml](gateway/internal/gateway-class.yaml) | Class of the Internal Gateway, references the `internal-gateway-config` EnvoyProxy to apply its config to all gateways of this class. |
| NetworkPolicy | internal-gateway | [gateway/internal/network-policy.yaml](gateway/internal/network-policy.yaml) | Allows incoming connections from cluster LAN devices, and forwarding requests to backends. |

# Grafana

[Grafana](https://grafana.com/oss/grafana/?plcmt=oss-nav) hosts dashboards for visualising observability data, primarily stored in InfluxDB.

Dashboards in `/dashboards` are provisioned in Grafana.
Datasources in `/datasources` are provisioned in Grafana.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| BackendTLSPolicy | grafana | [backend-tls-policy.yaml](backend-tls-policy.yaml) | Configures TLS verification between the API gateway and Grafana service it routes traffic to. |
| Certificate | grafana | [certificate.yaml](certificate.yaml) | Requests a set of TLS certificates from Cert Manager for the Grafana server to use. |
| HelmRelease | grafana | [helm.yaml](helm.yaml) | Installs Grafana. |
| HelmRepository | grafana | [helm.yaml](helm.yaml) | Grafana Helm charts. |
| HTTPRoute | grafana-route | [http-route.yaml](http-route.yaml) | Routes traffic from the Gateway to the `grafana` Service, authenticating with the credential-injection HTTPRouteFilter. |
| HTTPRouteFilter | credential-injection | [http-route.yaml](http-route.yaml) | The gateway provides OIDC authentication, so this configures credential injection with the `grafana-basic-auth` Secret to automatically authenticate to the Grafana server. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Namespace | grafana | [namespace.yaml](namespace.yaml) |  |
| ServiceAccount | grafana | [service-account.yaml](service-account.yaml) | ServiceAccount for Grafana to use. |
| VaultAuth | grafana | [vault-secrets.yaml](vault-secrets.yaml) | Authenticates the grafana ServiceAccount against the grafana Vault Kubernetes auth role. |
| VaultStaticSecret | grafana-basic-auth | [vault-secrets.yaml](vault-secrets.yaml) | Configures Vault Secrets Operator to populate the grafana-basic-auth Secret with Grafana admin user credentials in basic auth format. |
| VaultStaticSecret | grafana-auth | [vault-secrets.yaml](vault-secrets.yaml) | Configures Vault Secrets Operator to populate the grafana-auth Secret with Grafana admin user credentials. |
| VaultStaticSecret | influxdb-read-token | [vault-secrets.yaml](vault-secrets.yaml) | Configures Vault Secrets Operator to populate the influxdb-read-token Secret with a token with read permissions on InfluxDB to configure its datasource.|

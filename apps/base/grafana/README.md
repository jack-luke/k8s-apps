# Grafana

[Grafana](https://grafana.com/oss/grafana/?plcmt=oss-nav) hosts dashboards for visualising observability data, primarily stored in InfluxDB.

Dashboards in `/dashboards` are provisioned in Grafana.

Provisioned datasources are managed with Vault, due to credentials in their configuration.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| BackendTLSPolicy | grafana | [backend-tls-policy.yaml](backend-tls-policy.yaml) | Configures TLS verification between the API gateway and Grafana service it routes traffic to. |
| Certificate | grafana | [certificate.yaml](certificate.yaml) | Requests a set of TLS certificates from Cert Manager for the Grafana server to use. |
| HelmRelease | grafana | [helm.yaml](helm.yaml) | Installs Grafana. |
| HelmRepository | grafana | [helm.yaml](helm.yaml) | Grafana Helm charts. |
| HTTPRoute | grafana-route | [http-route.yaml](http-route.yaml) | Routes traffic from the API gateway to the Grafana service. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Namespace | grafana | [namespace.yaml](namespace.yaml) |  |
| ServiceAccount | grafana | [service-account.yaml](service-account.yaml) | ServiceAccount for Grafana to use. |
| VaultAuth | grafana | [vault-secrets.yaml](vault-secrets.yaml) | Authenticates the grafana ServiceAccount against the grafana Vault Kubernetes auth role. |
| VaultStaticSecret | grafana-auth | [vault-secrets.yaml](vault-secrets.yaml) | Configures Vault Secrets Operator to populate the grafana-auth Secret with Grafana admin user credentials. |
| VaultStaticSecret | grafana-datasources | [vault-secrets.yaml](vault-secrets.yaml) | Configures Vault Secrets Operator to populate the grafana-datasources Secret with a `datasources.yaml` file for connecting to InfluxDB and other data sources. |

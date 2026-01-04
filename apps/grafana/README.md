# Grafana

Installs Grafana with Helm. 

Dashboards in `/dashboards` are provisioned in Grafana.

Provisioned datasources are managed with Vault, due to credentials in their configuration.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| BackendTLSPolicy | grafana | [backend-tls-policy.yaml](backend-tls-policy.yaml) |  |
| Certificate | grafana | [certificate.yaml](certificate.yaml) |  |
| HelmRelease | grafana | [helm.yaml](helm.yaml) |  |
| HelmRepository | grafana | [helm.yaml](helm.yaml) |  |
| HTTPRoute | grafana-route | [http-route.yaml](http-route.yaml) |  |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Namespace | grafana | [namespace.yaml](namespace.yaml) |  |
| ServiceAccount | grafana | [service-account.yaml](service-account.yaml) |  |
| VaultAuth | grafana | [secret.yaml](secret.yaml) |  |
| VaultStaticSecret | grafana-auth | [secret.yaml](secret.yaml) |  |
| VaultStaticSecret | grafana-datasources | [secret.yaml](secret.yaml) |  |

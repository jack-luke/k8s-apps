# InfluxDB

Installs InfluxDB 2 with Helm.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| HelmRelease | influxdb | [helm.yaml](helm.yaml) | Installs InfluxDB v2. |
| HelmRepository | influxdb | [helm.yaml](helm.yaml) | InfluxDB Helm charts. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Namespace | influxdb | [namespace.yaml](namespace.yaml) |  |
| VaultAuth | influxdb | [secret.yaml](secret.yaml) | Authenticates the inflxudb ServiceAccount against the inflxudb Vault Kubernetes auth role. |
| VaultStaticSecret | influxdb-auth | [secret.yaml](secret.yaml) | Configures Vault Secrets Operator to populate the influxdb-auth Secret with InfluxDB admin user credentials and token. |

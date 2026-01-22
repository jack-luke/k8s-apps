# InfluxDB

[InfluxDB 2](https://docs.influxdata.com/influxdb/v2/) stores observability data from the cluster and other Homelab services.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| Certificate | influxdb | [certificate.yaml](certificate.yaml) | Requests a set of TLS certificates from Cert Manager for the InfluxDB server to use. |
| HelmRelease | influxdb | [helm-release.yaml](helm-release.yaml) | Installs InfluxDB v2. |
| HelmRepository | influxdb | [helm-repository.yaml](helm-repository.yaml) | InfluxDB Helm charts. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Namespace | influxdb | [namespace.yaml](namespace.yaml) |  |
| VaultAuth | influxdb | [vault-secrets.yaml](vault-secrets.yaml) | Authenticates the inflxudb ServiceAccount against the inflxudb Vault Kubernetes auth role. |
| VaultStaticSecret | influxdb-auth | [vault-secrets.yaml](vault-secrets.yaml) | Configures Vault Secrets Operator to populate the influxdb-auth Secret with InfluxDB admin user credentials and token. |

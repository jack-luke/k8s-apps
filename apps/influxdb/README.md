# InfluxDB

Installs InfluxDB 2 with Helm.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| HelmRelease | influxdb | [helm.yaml](helm.yaml) |  |
| HelmRepository | influxdb | [helm.yaml](helm.yaml) |  |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Namespace | influxdb | [namespace.yaml](namespace.yaml) |  |
| VaultAuth | influxdb | [secret.yaml](secret.yaml) |  |
| VaultStaticSecret | influxdb-auth | [secret.yaml](secret.yaml) |  |

# Vector

Vector observability tool deployed as a Daemonset.

Configuration of Vector data pipelines is done using `config/vector.yaml`

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| ClusterRole | log-reader-role | [cluster-role.yaml](cluster-role.yaml) |  |
| ClusterRoleBinding | log-reader-binding | [cluster-role.yaml](cluster-role.yaml) |  |
| DaemonSet | vector | [daemonset.yaml](daemonset.yaml) |  |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Namespace | vector | [namespace.yaml](namespace.yaml) |  |
| Service | vector | [service.yaml](service.yaml) |  |
| ServiceAccount | vector | [service-account.yaml](service-account.yaml) |  |
| VaultAuth | vector | [secret.yaml](secret.yaml) |  |
| VaultStaticSecret | vector-influxdb-token | [secret.yaml](secret.yaml) |  |

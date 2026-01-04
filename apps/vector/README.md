# Vector

Vector observability tool deployed as a Daemonset.

Configuration of Vector data pipelines is done using `config/vector.yaml`

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| ClusterRole | log-reader-role | [cluster-role.yaml](cluster-role.yaml) | Role to allow Vector to read all Kubernetes pod logs. |
| ClusterRoleBinding | log-reader-binding | [cluster-role.yaml](cluster-role.yaml) | Binds the log-reader-role to the vector ServiceAccount. |
| DaemonSet | vector | [daemonset.yaml](daemonset.yaml) | Deploys Vector to every node of the cluster. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Namespace | vector | [namespace.yaml](namespace.yaml) |  |
| Service | vector | [service.yaml](service.yaml) | Exposes Vector to consume external metrics. |
| ServiceAccount | vector | [service-account.yaml](service-account.yaml) | ServiceAccount for Vector to use. |
| VaultAuth | vector | [secret.yaml](secret.yaml) | Authenticates the vector ServiceAccount against the vector Vault Kubernetes auth role. |
| VaultStaticSecret | vector-influxdb-token | [secret.yaml](secret.yaml) | Configures Vault Secrets Operator to populate the influxdb-write-token Secret with an InfluxDB token that permits writing data. |

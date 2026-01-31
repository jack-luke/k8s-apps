# Vector

[Vector](https://vector.dev) observability tool collects & parses observability data and writes it to InfluxDB. 

Configuration of Vector data pipelines is done using `config/vector.yaml`

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| ClusterRole | log-reader-role | [cluster-role.yaml](cluster-role.yaml) | Role to allow Vector to read Kubernetes metadata. |
| ClusterRoleBinding | log-reader-binding | [cluster-role.yaml](cluster-role.yaml) | Binds the Vector Role to the vector ServiceAccount. |
| DaemonSet | vector | [daemonset.yaml](daemonset.yaml) | Deploys Vector to every node of the cluster. |
| GRPCRoute | vector | [grpc-route.yaml](grpc-route.yaml) | Routes gRPC events from the Vector Forwarding source to Vector via the Internal Gateway. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Namespace | vector | [namespace.yaml](namespace.yaml) |  |
| NetworkPolicy | vector | [network-policy.yaml](network-policy.yaml) | Allows ingestion of events from external sources, and writing them to InfluxDB. |
| Service | vector | [service.yaml](service.yaml) | Exposes Vector to consume external metrics. |
| ServiceAccount | vector | [service-account.yaml](service-account.yaml) | ServiceAccount for Vector to use. |
| VaultAuth | vector | [vault-secrets.yaml](vault-secrets.yaml) | Authenticates the vector ServiceAccount against the vector Vault Kubernetes auth role. |
| VaultStaticSecret | vector-influxdb-token | [vault-secrets.yaml](vault-secrets.yaml) | Configures Vault Secrets Operator to populate the influxdb-write-token Secret with an InfluxDB token that permits writing data. |

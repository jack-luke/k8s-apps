# Memcached

[Memcached](https://memcached.org/) deploys a memcached cache cluster, and a daemonset of memcached proxy nodes which manage replication and sharding of cache entries.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Namespace |  | [namespace.yaml](namespace.yaml) |  |

### ./cache
Resources for deploying the memcached cache cluster.

| Kind | Name | File | Description |
| --- | --- | --- | --- |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Service | cache-headless | [cache/service.yaml](cache/service.yaml) | Headless Service to expose StatefulSet cache nodes. |
| StatefulSet | memcached | [cache/statefulset.yaml](cache/statefulset.yaml) | Memcached nodes. |

### ./proxy
Resources for deploying the memcached proxy. Proxy configuration is defined in `config.lua`.

| Kind | Name | File | Description |
| --- | --- | --- | --- |
| DaemonSet | memcached-proxy | [proxy/daemonset.yaml](proxy/daemonset.yaml) | Memcached proxy to handle requests to the memcached cluster. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Service | cache-proxy | [proxy/service.yaml](proxy/service.yaml) | Service to expose the proxy. |
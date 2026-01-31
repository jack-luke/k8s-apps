# Vector Configuration

Files that configure the data sources, transforms, and sinks that Vector implements.

| File | Description |
| --- | --- |
| [kubernetes-logs.yaml](kubernetes-logs.yaml) | Collects & processes logs from the Kubernetes node and the Vector pod itself. |
| [metrics.yaml](metrics.yaml) | Collects & processes metrics from Vector, the host machine, and any Kubernetes metrics sources. |
| [forwarding.yaml](forwarding.yaml) | Recieves events forwarded from other Vector instances in the homelab. |

## Help & Resources
* [Configuring Vector](https://vector.dev/docs/reference/configuration/)
* [Vector Remap Language](https://vector.dev/docs/reference/vrl/)
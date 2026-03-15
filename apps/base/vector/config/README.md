# Vector Configuration

Files that configure the data sources, transforms, and sinks that Vector implements.

| File | Description |
| --- | --- |
| [kubernetes-logs.yaml](kubernetes-logs.yaml) | Collects & processes logs from the Kubernetes node and the Vector pod itself. |
| [metrics.yaml](metrics.yaml) | Collects & processes metrics from Vector, the host machine, and any Kubernetes metrics sources. |
| [forwarding.yaml](forwarding.yaml) | Recieves events forwarded from other Vector instances in the homelab. |

## Environment Variables
| Variable | Description |
| --- | --- |
| `VECTOR_SELF_NODE_NAME` | Hostname that Vector tags metrics with. Set as node name from pos spec. |
| `VECTOR_SERVICE_PORT_STATSD` | Vector listens on this port for StatsD UDP connections. Kubernetes automatically sets this to the `statsd` port of the `vector` service.  |
| `VECTOR_SERVICE_PORT_FORWARDING` | Vector listens on this port for metrics forwarded over gRPC. Kubernetes automatically sets this to the `forwarding` port of the `vector` service. |
| `VECTOR_CONFIG_DIR` | Directory Vector searches in for config files. |
| `VECTOR_WATCH_CONFIG` | If `true`, Vector periodically checks the config dir and reloads the service upon changes. |
| `INFLUXDB_SERVER_NAME` | Name of the InfluxDB server as it appears in its TLS certificate. |
| `INFLUXDB_ADDR` | `SCHEME://HOST:PORT` address of the InfluxDB server to write events to. |
| `INFLUXDB_CA_FILE` | Path to a certificate to verify the InfluxDB server with. |
| `INFLUXDB_TOKEN` | An InfluxDB token that has write permission on the required bucket. |

## Help & Resources
* [Configuring Vector](https://vector.dev/docs/reference/configuration/)
* [Vector Remap Language](https://vector.dev/docs/reference/vrl/)
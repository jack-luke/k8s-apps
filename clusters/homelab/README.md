# Homelab

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| Kustomization | cert-manager | [infrastructure.yaml](infrastructure.yaml) | [Cert Manager](https://cert-manager.io) creates and distrbutes TLS certificates within the cluster, using Vault as its Certificate Authorty. |
| Kustomization | envoy | [infrastructure.yaml](infrastructure.yaml) | [Envoy](https://gateway.envoyproxy.io/) manages a gateway utilising the Kubernetes Gateway API to allow secure access to the cluster. |
| Kustomization | grafana | [apps.yaml](apps.yaml) | [Grafana](https://grafana.com/oss/grafana/?plcmt=oss-nav) hosts dashboards for visualising observability data, primarily stored in InfluxDB. |
| Kustomization | influxdb | [apps.yaml](apps.yaml) | [InfluxDB](https://docs.influxdata.com/influxdb/v2/) stores observability data from the cluster and other Homelab services. |
| Kustomization | k8s-apps | [kustomization.yaml](kustomization.yaml) | Referenced by Flux running in the cluster; calls all other application Kustomizations. |
| Kustomization | registry | [apps.yaml](apps.yaml) | Registry deploys a Docker image registry to the cluster for local image access. |
| Kustomization | vault | [infrastructure.yaml](infrastructure.yaml) | HashiCorp [Vault](https://developer.hashicorp.com/vault) and [Vault Secrets Operator](https://developer.hashicorp.com/vault/docs/deploy/kubernetes/vso) provide cluster secrets management. |
| Kustomization | vector | [apps.yaml](apps.yaml) | [Vector](https://vector.dev) observability tool collects & parses observability data and writes it to InfluxDB. |

## Infrastructure Dependencies

Services defined in [/apps](/apps) may depend on resources provided by services in [/infrastructure](/infrastructure).

### Vault
Apps that require secrets to be injected should include a `secret.yaml` file 
which defines how they authenticate with Vault, and how the secret is deployed
by the Vault Secrets Operator.

Below is an example of how to create VaultAuth and VaultStaticSecret manifests 
to render Vault key-value secrets as Kubernetes Secrets.

#### Parameters
| Name | Description |
| --- | --- |
| AppName | Name of the app |
| AppNamespace | Name of the app namespace |
| VaultKvPath | Path of the Vault key-value mount |
| VaultSecretName | End path of the Vault secret |
| K8sSecretName | Name of the Kubernetes secret to render |

```yaml
apiVersion: secrets.hashicorp.com/v1beta1
kind: VaultAuth
metadata:
  name: <AppName>
  namespace: <AppNamespace>
spec:
  method: kubernetes
  mount: kubernetes
  kubernetes:
    role: <AppName>
    serviceAccount: <AppName>
    audiences:
      - vault://<AppNamespace>/<AppName>
---
apiVersion: secrets.hashicorp.com/v1beta1
kind: VaultStaticSecret
metadata:
  name: <AppName>-<VaultSecretName>
  namespace: <AppNamespace>
spec:
  type: kv-v2
  mount: <VaultKvPath>
  path: <AppNamespace>/<AppName>/<VaultSecretName>
  destination:
    name: <K8sSecretName>
    create: true
  refreshAfter: 30s
  vaultAuthRef: <AppName>
```

These apps therefore should include the following tag in their Kustomization:
```yaml
spec:
  dependsOn:
    - name: vault
```

### Envoy
Apps that require external cluster access should do so via the Envoy Gateway.

The application namespace reached through the Envoy Gateway requires the 
following label to permit gateway access:
```yaml
metadata:
  labels:
    gateway_access: "true"
```

To route traffic from the gateway to existing application services, an 
HTTPRoute like the example below is required:

#### Parameters
| Name | Description |
| --- | --- |
| AppName | Name of the app |
| AppNamespace | Name of the app namespace |
| ServiceName | Name of the service that points to the application pods |
| ServicePort | Port of the service to direct gateway traffic to |

```yaml
apiVersion: gateway.networking.k8s.io/v1beta1
kind: HTTPRoute
metadata:
  name: <AppName>
  namespace: <AppNamespace>
spec:
  parentRefs:
    - name: api-gateway
      namespace: envoy
  rules:
    - backendRefs:
        - name: <ServiceName>
          namespace: <AppNamespace>
          port: <ServicePort>
```

The gateway has TLS configured with Cert Manager, so all apps it serves can be
securely accessed from outside the cluster. However, if TLS between the gateway
and backend is required, this can be configured as well with a 
`BackendTLSPolicy` resource as shown in [Envoy Gateway Docs: Backend TLS: Gateway to Backend](https://gateway.envoyproxy.io/docs/tasks/security/backend-tls/)

These apps should also include the following tag in their Kustomization:
```yaml
spec:
  dependsOn:
    - name: envoy
```

### Cert Manager
Apps that require TLS client certificates should request them via Cert Manager.

The example Certificate manifest below shows how to request certitificates:

#### Parameters
| Name | Description |
| --- | --- |
| AppName | Name of the app |
| AppNamespace | Name of the app namespace |
| K8sSecretName | Name of the Kubernetes secret to render TLS certificates in |

```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: <AppName>
  namespace: <AppNamespace>
spec:
  secretName: <K8sSecretName>
  duration: 2160h # 90d
  renewBefore: 360h # 15d
  isCA: false
  usages:
    - server auth
    - client auth
  commonName: <AppName>
  issuerRef:
    name: vault-issuer
    kind: ClusterIssuer
    group: ""
```

These apps should also include the following tag in their Kustomization:
```yaml
spec:
  dependsOn:
    - name: cert-manager
```
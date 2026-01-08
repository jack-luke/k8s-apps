# Application Onboarding

## Integrating with Infrastructure Services

Services defined in [/apps](/apps) may utilise resources provided by services
in [/infrastructure](/infrastructure), below is a guide on integrating apps 
with the provided infrastructure services.

### Vault
Secrets that applications require are stored in Vault, and rendered as 
Kubernetes Secrets with the Vault Secrets Operator.

Apps that require secrets to be injected should include a `vault-secrets.yaml` 
file which defines how they authenticate with Vault, and how the secret is 
deployed by the Vault Secrets Operator.

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

### Cert Manager
Apps that require TLS client certificates should request them via Cert Manager.

The example Certificate manifest below shows how to request certificates from 
the Vault ClusterIssuer:

#### Parameters
| Name | Description |
| --- | --- |
| AppName | Name of the app |
| AppNamespace | Name of the app namespace |

```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: <AppName>
  namespace: <AppNamespace>
spec:
  duration: 2160h # 90d
  renewBefore: 360h # 15d
  usages:
    - server auth
    - client auth
  commonName: <AppName>.<AppNamespace>.svc.cluster.local
  dnsNames:
    - <AppName>
    - <AppName>.<AppNamespace>
    - <AppName>.<AppNamespace>.svc
    - <AppName>.<AppNamespace>.svc.cluster.local
```
> [!NOTE]
> The Kyverno `certificate-defaults` ClusterPolicy sets the secret name to 
> '{{ AppName }}-tls' if omitted, and defaults to using the 'vault-issuer' ClusterIssuer

## Documenting Applications

The manifests of every application are documented in a table in its `README.md`. 

The table is started using:
```markdown
## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
```

The manifests are captured in the table by running the following command from the application directory (requires [yq](https://mikefarah.gitbook.io/yq#install)):
```bash
for f in *.yaml; do yq eval -r '"| " + .kind + " | " + .metadata.name + " | ['"$f"']('"$f"') |  |"' "$f"; done | sort | uniq >> README.md
```

Descriptions can then be filled in for each manifest. 
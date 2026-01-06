# Kubernetes Homelab Applications

Flux repository for Homelab Kubernetes applications, synced automatically to clusters installed with the [k8s-bootstrap](https://github.com/jack-luke/k8s-bootstrap) project.

## Usage
### Sync with Flux Operator
To sync the `homelab` cluster environment of this repository to a cluster 
running [Flux Operator](https://fluxoperator.dev/get-started/), configure a 
`sync` block in your FluxInstance like so:

```yaml
apiVersion: fluxcd.controlplane.io/v1
kind: FluxInstance
spec:
  sync:
    name: k8s-apps
    kind: GitRepository
    url: "https://github.com/jack-luke/k8s-apps.git"
    ref: "refs/heads/main"
    path: "clusters/homelab"
```

## Vault Configuration
### TLS
Vault manages a PKI to provide TLS for the whole cluster, however the TLS 
certificates for the Vault server and a CA certificate to verify them are 
required to exist as Kubernetes Secrets before installing this project.

Generate the certificates as shown in: 
[Cert Manager: Vault Issuer Docs](https://cert-manager.io/docs/configuration/vault/#accessing-a-vault-server-with-mtls-enforced) 
and apply the secrets as shown:
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: vault-server-tls
  namespace: vault
type: Opaque
data:
  vault.ca: # PEM-encoded CA certificate used to sign Vault server leaf certificate
  vault.crt: # PEM-encoded Vault server leaf certificate
  vault.key: # PEM-encoded Vault server key
---
apiVersion: v1
kind: Secret
metadata:
  name: vault-ca
  namespace: vault
type: Opaque
data:
  ca.crt: # PEM-encoded CA certificate used to sign Vault server leaf certificate
```

### Secrets & Authentication
All applications and services in the repository leverage Vault and Vault 
Secrets Operator for secrets management. 

So, before secrets can be rolled out:
* The Vault server must be initialised & unsealed
* Vault Secrets Engines, Auth Methods, & Policies must be configured for the required secrets
* All secrets must be stored in the Vault server

> [!NOTE] 
> I also maintain a project which securely automates this process with Terraform and GitLab CI, however it is not yet ready for release.

The details of the secret locations and authentication role names required for
each secret are documented in the README.md files of the individual 
applications.

## Project Structure
```bash
.
├── apps # Applications to be deployed to the cluster
│   ├── base
│   │   └── <app>/
│   └── homelab
├── clusters # Environment definitions 
│   └── homelab
└── infrastructure # Services that are deployed to support applications
    ├── configs
    │   └── <app>/
    └── controllers
        └── <app>/
```

### Infrastructure
#### Controllers
Contains resources to install the infrastructure service and any CRDs it 
utilises, which are primarily HelmRepositories and HelmReleases.
Additionally, any Namespaces or ServiceAccounts the infrastructure services 
require to deploy should be created here.

#### Configs
Contains resources to configure infrastructure services, such as Gateways, 
ClusterIssuers etc. 
This depends on the infrastructure controllers to ensure that all CRDs are 
installed prior to installing these resources.

### Apps
Depends on the infrastructre configs, to ensure that all CRDs and supporting services are 
installed.

#### Base
The base configuration for each application.

#### {{ Environments }}
A directory for every cluster environment defined in [/clusters](/clusters), 
containing overlays to configure the infrastructure and applications for the
target environment.

## Help & Resources
* [flux2-kustomize-helm-example](https://github.com/fluxcd/flux2-kustomize-helm-example/tree/main) (used as the basis for this repo structure)
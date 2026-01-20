# Kubernetes Homelab Applications

Flux repository for Homelab Kubernetes applications, synced automatically to clusters
installed with the [k8s-bootstrap](https://github.com/jack-luke/k8s-bootstrap) project.

The structure is based on this project from FluxCD: [flux2-kustomize-helm-example](https://github.com/fluxcd/flux2-kustomize-helm-example/tree/main)

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

## Project Structure
```bash
.
├── apps # Applications to be deployed to the cluster
│   ├── base
│   │   └── <app>/
│   └── homelab
├── clusters # Environment definitions 
│   └── homelab
├── infrastructure # Services that are deployed to support applications
│   ├── configs
│   │   └── <app>/
│   └── controllers
│   │   └── <app>/
└── policy # Policy engines that govern cluster compliance
    ├── controllers
    │   └── <app>/
    └── policies
```

### Infrastructure
`/infrastructure/controllers` contains the `infra-controllers` Kustomization and resources to
install the infrastructure service and any CRDs it utilises. 
Depends on the `policies` Kustomization, to ensure that all policy rules are in
place prior to installing these resources.

`/infrastructure/configs` contains the `infra-configs` Kustomization and resources to configure
infrastructure services, such as Gateways, ClusterIssuers etc. 
Depends on the `infra-controllers` Kustomization to ensure that all CRDs 
are installed prior to installing these resources.

### Apps
Installs cluster applications. This contains the 'base' configuration for each
application, and a directory for every cluster environment defined in 
`/clusters` containing overlays to configure the infrastructure and
applications for the target environment.

Depends on the `infra-configs` Kustomization, to ensure that all CRDs and 
supporting services are installed prior to installing these resources.

### Policy
`/policy/controllers` contains the `policy-controllers` Kustomization and all
policy engines in the cluster to ensure CRDs exist before applying policies.

`/policy/policies` contains the `policies` Kustomiaztion and all policy rules
that should be applied to the cluster. 
Depends on the `policy-controllers` Kustomization, to ensure that all CRDs and 
policy engines are installed prior to installing these resources.

## Secrets Management
All applications and services in the repository leverage Vault and Vault 
Secrets Operator for secrets management. 

> [!NOTE]
> The details of the secret locations and authentication role names required 
> for each secret are documented in the README.md files of the individual 
> applications.

The diagrams below show how secrets are setup and managed in the cluster.

### Bootstrap & Trust Distribution
Certificates are delivered to the cluster via CI/CD during setup. This allows 
Vault to communicate over TLS, and allows Vault Secrets Operator to verify the
Vault server's certificate.

Then, Vault Secrets Operator delivers CA bundles for the Vault server and 
Vault PKI issuer to Trust Manager so that it can distribute them cluster-wide.

Now the Vault server is setup with TLS, and all cluster workloads are able to 
trust the Vault server and any certificates it issues.

<img src="./assets/bootstrap_and_trust.svg" width=80% alt="Diagram of the workflow for setting up Vault TLS and CA trust mechanisms in the cluster" >

#### Help & Resources
* [Vault Standalone with TLS](https://developer.hashicorp.com/vault/docs/deploy/kubernetes/helm/examples/standalone-tls)
* [Vault HA with TLS](https://developer.hashicorp.com/vault/docs/deploy/kubernetes/helm/examples/ha-tls)
* [Vault Secrets Operator Docs](https://developer.hashicorp.com/vault/docs/deploy/kubernetes/vso)
* [Trust Manager Usage](https://cert-manager.io/docs/trust/trust-manager/)


### Issuing Certificates
To setup secure communications between workloads, a Cert Manager ClusterIssuer 
is used, which uses the Vault PKI issuing CA to sign certificate requests. 

These signed certificates are then automatically rendered as TLS secrets for 
the workloads to use. Trust Manager distributes the CA bundle for the Vault PKI
issuing CA to every namespace, which workloads then use to verify the 
certificates of their neighbours.

The diagram below shows an example of how this works with Grafana reading data 
from InfluxDB.

<img src="./assets/certs.svg" width=80% alt="Diagram of the workflow for issuing certificates to apps with Cert Manager and Vault" >

#### Help & Resources
* [Vault Tutorial: Build a CA with an offline root](https://developer.hashicorp.com/vault/tutorials/pki/pki-engine-external-ca)
* [Cert Manager Vault Issuer Tutorial](https://cert-manager.io/docs/configuration/vault/)
* [Trust Manager Usage](https://cert-manager.io/docs/trust/trust-manager/)


### OIDC Authentication
Envoy Gateway is used to provide simple and secure access to cluster services,
with OIDC authentication and TLS provided by Vault.

The diagram below shows how access to Grafana is secured via the Gateway with
Envoy Gateway custom resources.

Central to OIDC authentication is the SecurityPolicy custom resource. When 
users access the Gateway, the SecurityPolicy forces all requests to be 
authenticated with OIDC before routing them to the backend service.

The general workflow is as follows:
* Unauthenticated user accesses Gateway via browser.
* SecurityPolicy detects unauthed request, and redirects user to Vault UI, submitting OIDC client credentials provided by Vault Secrets Operator.
* User logs into Vault UI, which is hosting the OIDC provider.
* Upon login success, Vault issues an OAuth 2.0 token and redirects to the Gateway using the callback URL.
* SecurityPolicy is now served a request with valid OAuth 2.0 token, so it passes request to Grafana backend.
* Gateway terminates client TLS and establishes TLS communication to the Grafana backend.
* To prevent a second authentication in Grafana, basic auth credentials are injected into the request and the login form is disabled.
* User is served the requested resources from Grafana.

<img src="./assets/oidc.svg" width=80% alt="Diagram of the workflow for OIDC authentication with Envoy Gateway and Vault" >

#### Help & Resources
* [Vault OIDC Provider Docs](https://developer.hashicorp.com/vault/docs/secrets/identity/oidc-provider)
* [Envoy Gateway OIDC Authentication](https://gateway.envoyproxy.io/docs/tasks/security/oidc/)
* [Envoy Gateway TLS: Client to Gateway](https://gateway.envoyproxy.io/docs/tasks/security/secure-gateways/)
* [Envoy Gateway TLS: Gateway to Backend](https://gateway.envoyproxy.io/docs/tasks/security/backend-tls/)
* [Envoy Gateway Credential Injection](https://gateway.envoyproxy.io/docs/tasks/security/credential-injection/)
* [Run Grafana behind a reverse proxy](https://grafana.com/tutorials/run-grafana-behind-a-proxy/)
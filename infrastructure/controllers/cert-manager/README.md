# Cert Manager Controller

[Cert Manager](https://cert-manager.io) creates and distrbutes TLS certificates within the cluster, using Vault as its Certificate Authorty.

## Manifests
| Kind | Name | File | Description|
| --- | --- | --- | --- |
| HelmRelease | cert-manager | [cert-manager.yaml](cert-manager.yaml) | Installs Cert Manager. | 
| HelmRelease | trust-manager | [trust-manager.yaml](trust-manager.yaml) | Installs Trust Manager. |
| HelmRepository | jetstack | [helm-repository.yaml](helm-repository.yaml) | Jetstack Helm Charts. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) | |
| Namespace | cert-manager | [namespace.yaml](namespace.yaml) | |
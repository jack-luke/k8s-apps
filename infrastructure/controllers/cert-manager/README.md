# Cert Manager Controller

[Cert Manager](https://cert-manager.io) creates and distrbutes TLS certificates within the cluster, using Vault as its Certificate Authorty.

## Manifests
| Kind | Name | File | Description|
| --- | --- | --- | --- |
| HelmRelease | cert-manager | [cert-manager-helm-release.yaml](cert-manager-helm-release.yaml) | Installs Cert Manager. | 
| HelmRelease | trust-manager | [trust-manager-helm-release.yaml](trust-manager-helm-release.yaml) | Installs Trust Manager. |
| HelmRepository | jetstack | [helm-repository.yaml](helm-repository.yaml) | Jetstack Helm Charts. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) | |
| Namespace | cert-manager | [namespace.yaml](namespace.yaml) | |
# Vault Controller

HashiCorp [Vault](https://developer.hashicorp.com/vault) and [Vault Secrets Operator](https://developer.hashicorp.com/vault/docs/deploy/kubernetes/vso) provide cluster secrets management.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| HelmRelease | vault | [vault-helm-release.yaml](vault-helm-release.yaml) | Installs Vault. |
| HelmRelease | vault-secrets-operator | [vault-secrets-operator-helm-release.yaml](vault-secrets-operator-helm-release.yaml) | Installs Vault Secrets Operator. |
| HelmRepository | vault | [helm-repository.yaml](helm-repository.yaml) | HashiCorp Helm Charts. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Namespace | vault | [namespace.yaml](namespace.yaml) |  |

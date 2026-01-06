# Vault Controller

HashiCorp [Vault](https://developer.hashicorp.com/vault) and [Vault Secrets Operator](https://developer.hashicorp.com/vault/docs/deploy/kubernetes/vso) provide cluster secrets management.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| HelmRelease | vault | [vault-helm.yaml](vault-helm.yaml) | Installs Vault. |
| HelmRelease | vault-secrets-operator | [secrets-operator-helm.yaml](secrets-operator-helm.yaml) |  Installs Vault Secrets Operator. |
| HelmRepository | vault | [helm-repository.yaml](helm-repository.yaml) |  HashiCorp Helm charts. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) | |
| Namespace | vault | [namespace.yaml](namespace.yaml) | |
| ServiceAccount | vault-secrets-operator-controller-manager | [secrets-operator-sa.yaml](secrets-operator-sa.yaml) | ServiceAccount for Vault Secrets Operator. |

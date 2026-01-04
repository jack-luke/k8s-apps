# Vault

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| HelmRelease | vault | [vault-helm.yaml](vault-helm.yaml) | Installs Vault. |
| HelmRelease | vault-secrets-operator | [secrets-operator-helm.yaml](secrets-operator-helm.yaml) |  Installs Vault Secrets Operator. |
| HelmRepository | vault | [helm-repository.yaml](helm-repository.yaml) |  HashiCorp Helm charts. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) | |
| Namespace | vault | [namespace.yaml](namespace.yaml) | |
| ServiceAccount | vault-secrets-operator-controller-manager | [secrets-operator-sa.yaml](secrets-operator-sa.yaml) | ServiceAccount for Vault Secrets Operator. |
| VaultAuth | client-cache-auth | [secrets-operator-auth.yaml](secrets-operator-auth.yaml) |  Authenticates the vault-secrets-operator-controller-manager ServiceAccount against the vault-secrets-operator Vault Kubernetes auth role. |

# Vault Controller

HashiCorp [Vault](https://developer.hashicorp.com/vault) and [Vault Secrets Operator](https://developer.hashicorp.com/vault/docs/deploy/kubernetes/vso) provide cluster secrets management.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| HelmRelease | secrets-store-csi-driver | [secrets-store-csi-driver.yaml](secrets-store-csi-driver.yaml) | Installs the Secerts Store CSI Driver. |
| HelmRelease | vault | [vault.yaml](vault.yaml) | Installs Vault. |
| HelmRelease | vault-secrets-operator | [vault-secrets-operator.yaml](vault-secrets-operator.yaml) | Installs Vault Secrets Operator. |
| HelmRepository | secrets-store-csi-driver | [helm-repository.yaml](helm-repository.yaml) | Kubernetes Secrets Store CSI Driver Helm charts. |
| HelmRepository | vault | [helm-repository.yaml](helm-repository.yaml) | HashiCorp Helm Charts. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Namespace | vault | [namespace.yaml](namespace.yaml) |  |
| ServiceAccount | vault-secrets-operator-controller-manager | [vault-secrets-operator.yaml](vault-secrets-operator.yaml) | ServiceAccount for Vault Secrets Operator. |

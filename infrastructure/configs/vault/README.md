# Vault Configuration

HashiCorp [Vault](https://developer.hashicorp.com/vault) and [Vault Secrets Operator](https://developer.hashicorp.com/vault/docs/deploy/kubernetes/vso) provide cluster secrets management.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| NetworkPolicy | vault | [vault-network-policy.yaml](vault-network-policy.yaml) | Allows connections from Vault Secrets Opeator, Cert Manager, and Envoy Gateway for secrets operations, egress to Vector for metrics, and egress to the Kubernetes API for verifying ServiceAccount tokens. |
| NetworkPolicy | vault-secrets-operator | [vault-secrets-operator-network-policy.yaml](vault-secrets-operator-network-policy.yaml) | Allows reading secrets from Vault. |

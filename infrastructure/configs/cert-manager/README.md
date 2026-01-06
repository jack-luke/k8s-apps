# Cert Manager Configuration

[Cert Manager](https://cert-manager.io) creates and distrbutes TLS certificates within the cluster, using Vault as its Certificate Authorty.

## Manifests
| Kind | Name | File | Description|
| --- | --- | --- | --- |
| Bundle | vault-issuer-ca | [trust-bundle.yaml](trust-bundle.yaml) | Trust Manager Bundle containing the CA chain of the Vault issuing PKI mount. |
| ClusterIssuer | vault-issuer | [cluster-issuer.yaml](cluster-issuer.yaml) | Cert Manager Vault ClusterIssuer for issuing certificates from the Vault issuing PKI mount. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) | |
| Role | vault-issuer | [rbac.yaml](rbac.yaml) | Permits Cert Manager to create ServiceAccount tokens for vault-issuer. |
| RoleBinding | vault-issuer | [rbac.yaml](rbac.yaml) | Binds the vault-issuer Role to the cert-manager ServiceAccount. | 
| ServiceAccount | vault-issuer | [cluster-issuer-sa.yaml](cluster-issuer-sa.yaml) | ServiceAccount for the Cert Manager Vault ClusterIssuer |
| VaultAuth | cert-manager | [cert-manager-secret.yaml](cert-manager-secret.yaml) | Authenticates the cert-manager ServiceAccount against the cert-manager Vault Kubernetes auth role. |
| VaultAuth | trust-manager | [trust-manager-secret.yaml](trust-manager-secret.yaml) | Authenticates the trust-manager ServiceAccount against the trust-manager Vault Kubernetes auth role. |
| VaultStaticSecret | cert-manager-ca-bundle | [cert-manager-secret.yaml](cert-manager-secret.yaml) | Configures Vault Secrets Operator to populate the vault-ca Secret with the Vault server CA certificate. |
| VaultStaticSecret | trust-manager-ca-bundle | [trust-manager-secret.yaml](trust-manager-secret.yaml) | Configures Vault Secrets Operator to populate the vault-issuer-ca Secret with the Vault issuing CA certificate bundle. |
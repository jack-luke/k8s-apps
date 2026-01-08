# Cert Manager Configuration

[Cert Manager](https://cert-manager.io) creates and distrbutes TLS certificates within the cluster, using Vault as its Certificate Authorty.

## Manifests
| Kind | Name | File | Description|
| --- | --- | --- | --- |
| Bundle | vault-issuer-ca | [trust-bundle.yaml](trust-bundle.yaml) | Trust Manager Bundle containing the CA chain of the Vault issuing PKI mount. |
| Bundle | vault-server-ca | [trust-bundle.yaml](trust-bundle.yaml) | Trust Manager Bundle containing the CA chain of the Vault server. |
| ClusterIssuer | vault-issuer | [cluster-issuer.yaml](cluster-issuer.yaml) | Cert Manager Vault ClusterIssuer for issuing certificates from the Vault issuing PKI mount. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) | |
| Role | vault-issuer | [cluster-issuer-rbac.yaml](cluster-issuer-rbac.yaml) | Permits Cert Manager to create ServiceAccount tokens for vault-issuer. |
| RoleBinding | vault-issuer | [cluster-issuer-rbac.yaml](cluster-issuer-rbac.yaml) | Binds the vault-issuer Role to the cert-manager ServiceAccount. | 
| ServiceAccount | vault-issuer | [cluster-issuer-sa.yaml](cluster-issuer-sa.yaml) | ServiceAccount for the Cert Manager Vault ClusterIssuer |
| VaultAuth | trust-manager | [trust-manager-vault-secrets.yaml](trust-manager-vault-secrets.yaml) | Authenticates the trust-manager ServiceAccount against the trust-manager Vault Kubernetes auth role. |
| VaultStaticSecret | trust-manager-vault-issuer-ca-bundle | [trust-manager-vault-secrets.yaml](trust-manager-vault-secrets.yaml) | Configures Vault Secrets Operator to populate the vault-issuer-ca Secret with the Vault issuing CA certificate bundle. |
| VaultStaticSecret | trust-manager-vault-server-ca-bundle | [trust-manager-vault-secrets.yaml](trust-manager-vault-secrets.yaml) | Configures Vault Secrets Operator to populate the vault-server-ca Secret with the Vault server CA certificate. |
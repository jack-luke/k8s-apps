# Kyverno Controller

[Kyverno](https://kyverno.io) is a policy-as-code tool that manages & enforces 
cluster security configurations.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| HelmRelease | kyverno | [helm-release.yaml](helm-release.yaml) | Installs Kyverno. |
| HelmRepository | kyverno | [helm-repository.yaml](helm-repository.yaml) | Kyverno Helm charts. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Namespace | kyverno | [namespace.yaml](namespace.yaml) |  |
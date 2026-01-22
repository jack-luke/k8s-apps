# Reloader

[Reloader](https://github.com/stakater/Reloader) reloads Kubernetes workloads when Secrets or ConfigMaps they use change.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| HelmRelease | reloader | [helm-release.yaml](helm-release.yaml) | Installs Reloader. |
| HelmRepository | stakater | [helm-repository.yaml](helm-repository.yaml) | Stakater Helm charts. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Namespace | reloader | [namespace.yaml](namespace.yaml) |  |

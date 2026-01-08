# Reloader

[Reloader](https://github.com/stakater/Reloader) reloads Kubernetes workloads when Secrets or ConfigMaps they use change.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| HelmRelease | reloader | [helm.yaml](helm.yaml) | Installs Reloader. |
| HelmRepository | stakater | [helm.yaml](helm.yaml) | Stakater Helm charts. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Namespace | reloader | [namespace.yaml](namespace.yaml) |  |

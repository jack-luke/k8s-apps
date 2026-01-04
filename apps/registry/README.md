# Registry

Deploys a container registry.

## Manifests
| Kind | Name | File | Description |
| --- | --- | --- | --- |
| Deployment | registry | [deployment.yaml](deployment.yaml) | Deploys the registry server. |
| Kustomization |  | [kustomization.yaml](kustomization.yaml) |  |
| Namespace | registry | [namespace.yaml](namespace.yaml) |  |
| PersistentVolumeClaim | registry-pvc | [pvc.yaml](pvc.yaml) | Claims cluster storage for container images. |
| Service | registry-service | [service.yaml](service.yaml) | Exposes the registry on its standard port 5000. |
| ServiceAccount | registry | [service-account.yaml](service-account.yaml) | ServiceAccount for the registry to use. |

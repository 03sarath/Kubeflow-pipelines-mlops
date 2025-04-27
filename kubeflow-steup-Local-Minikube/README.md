## Psitron Kubeflow Pipelines
## Deploying Kubeflow on a Local Machine

## Prerequisites:
## Docker Desktop & Minikube
* Download & Install Docker Desktop:
* Visit the Docker Desktop download page to download and install Docker Desktop. https://www.docker.com/products/docker-desktop/

# Install Minikube:
Visit the Minikube installation page for installation instructions https://minikube.sigs.k8s.io/docs/start/. Once installed, run the following command in terminal to create a Minikube container:

``minikube start``

## Deploying Kubeflow Pipelines
* To deploy Kubeflow Pipelines, run the following commands:


```
export PIPELINE_VERSION=2.2.0
kubectl apply -k "github.com/kubeflow/pipelines/manifests/kustomize/cluster-scoped-resources?ref=$PIPELINE_VERSION"
kubectl wait --for condition=established --timeout=60s crd/applications.app.k8s.io
kubectl apply -k "github.com/kubeflow/pipelines/manifests/kustomize/env/platform-agnostic?ref=$PIPELINE_VERSION"
```

The Kubeflow Pipelines deployment may take several minutes to complete.
 * Verify that the Kubeflow Pipelines UI is accessible by port-forwarding:

``kubectl port-forward -n kubeflow svc/ml-pipeline-ui 8080:80
``
Check your Kubefloe status
```kubectl get pods -n kubeflow --watch```

* Then, open the Kubeflow Pipelines UI at ``http://localhost:8080/`` or - if you are using kind or K3s within a virtual machine - ``http://{YOUR_VM_IP_ADDRESS}:8080/``


<!-- license -->
## License
Distributed under the MIT License. See ``LICENSE.md`` for more information.


# Install and prepare MicroK8s

## Install MicroK8s
sudo snap install microk8s --channel=1.29-strict/stable
sudo usermod -a -G snap_microk8s ubuntu
newgrp snap_microk8s

## Enable MicroK8s addons
sudo microk8s enable dns hostpath-storage metallb:10.64.140.43-10.64.140.49 rbac
microk8s status

# Install Juju
sudo snap install juju --channel=3.4/stable
mkdir -p ~/.local/share

## As a next step we can configure microk8s to work properly with juju by running:
microk8s config | juju add-k8s my-k8s --client

## Deploy a Juju controller to the Kubernetes
juju bootstrap my-k8s uk8sx

## Add a model for Kubeflow to the controller
juju add-model kubeflow

# Deploy Charmed Kubeflow
sudo sysctl fs.inotify.max_user_instances=1280
sudo sysctl fs.inotify.max_user_watches=655360

## Deploy Charmed Kubeflow
juju deploy kubeflow --trust --channel=1.9/stable # You can expect "Deploy of bundle completed." once done with deployment

## Run any one to check status
juju status
juju status --watch 5s
nice -n 16 watch -n 1 -c juju status --relations --color

# Configure Dashboard Access (Run again if failed after few min)
microk8s kubectl -n kubeflow get svc istio-ingressgateway-workload -o jsonpath='{.status.loadBalancer.ingress[0].ip}'

juju config dex-auth public-url=http://10.64.140.43.nip.io
juju config oidc-gatekeeper public-url=http://10.64.140.43.nip.io

juju config dex-auth static-username=admin
juju config dex-auth static-password=admin

# Verify Charmed Kubeflow Deployment
## Enable Tunnel via SOCKS4 port 9999 to access Dashboard
http://10.64.140.43.nip.io




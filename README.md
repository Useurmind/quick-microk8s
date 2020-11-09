# quick-microk8s

This demo shows how to create a simple one VM microk8s cluster on azure purely using scripting.

The following steps need to be performed:

## Create VM using terraform
```
cd terraform
terraform init
terraform apply
```

## Install microk8s on VM

- First get the IP from the output of the terraform script
- Copy it into the `ansible/hosts.yml` file
- Execute ansible 

```
cd ansible
./install-microk8s.sh
```

- Adapt the IP in the `ansible/kubeconfig` file to the same ip of the terraform output
- Copy `ansible/kubeconfig` to `~/.kube/config` or integrate into your local kube config file

## (Optionally) Configure ingress for k8s dashboard
```
cd k8s
./install-dashboard.ps1
```
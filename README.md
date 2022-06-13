# Deploy and Setup Cert-manager and External Dependencies with the Terraform

## Goals

1. Deploy and setup Cert-manager and External Dependencies in test environment with Terraform.

2. To save time when working with external dependencies.


## Precondition

### Install `Kubectl`, `Helm`, `Terraform` and `Terragrunt` in Execution Host

These all are open source softwares, you can directly install them by official documentation.

#### Kubectl

Kubectl is used to perform actions that are not supported by native Terraform resources

[Install Kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)

#### Helm

Helm is the best way to find, share, and use software built for Kubernetes.

[Install Helm](https://helm.sh/docs/intro/install/)

#### Terraform

Terraform is an IT infrastructure automation orchestration tool.

[Install Terraform](https://www.terraform.io/downloads)

#### Terragrunt

Terragrunt is a thin wrapper that provides extra tools for keeping your configurations DRY, working with multiple Terraform modules, and managing remote state.

[Install Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)

### Configure Terraform Plugin Cache.

Each dependent configuration directory can share the cache to improve the execution speed.

```
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache" 
```

## Usage Steps

Take Vault as a example.

### 1. Go to the installation directory of specific dependency.

```
cd cm-vault
```

### 2. Execute `terragrunt run-all init`
```
[root@master68 cm-vault]# terragrunt run-all init
INFO[0000] The stack at /root/lonelyCZ/terraform-cm/cm-vault will be processed in the following order for command init:
Group 1
- Module /root/lonelyCZ/terraform-cm/cm-vault/cm-install
- Module /root/lonelyCZ/terraform-cm/cm-vault/vault-install

Group 2
- Module /root/lonelyCZ/terraform-cm/cm-vault/vault-config

Group 3
- Module /root/lonelyCZ/terraform-cm/cm-vault/cm-config


Initializing the backend...
```

### 3. Execute `terragrunt run-all apply`

```
[root@master68 cm-vault]# terragrunt run-all apply
INFO[0000] The stack at /root/lonelyCZ/terraform-cm/cm-vault will be processed in the following order for command apply:
Group 1
- Module /root/lonelyCZ/terraform-cm/cm-vault/cm-install
- Module /root/lonelyCZ/terraform-cm/cm-vault/vault-install

Group 2
- Module /root/lonelyCZ/terraform-cm/cm-vault/vault-config

Group 3
- Module /root/lonelyCZ/terraform-cm/cm-vault/cm-config

Are you sure you want to run 'terragrunt apply' in each folder of the stack described above? (y/n) y
```

### 4. Destroy Test Environment.

```
[root@master68 cm-vault]# terragrunt run-all destroy
INFO[0000] The stack at /root/lonelyCZ/terraform-cm/cm-vault will be processed in the following order for command destroy:
Group 1
- Module /root/lonelyCZ/terraform-cm/cm-vault/cm-config

Group 2
- Module /root/lonelyCZ/terraform-cm/cm-vault/cm-install
- Module /root/lonelyCZ/terraform-cm/cm-vault/vault-config

Group 3
- Module /root/lonelyCZ/terraform-cm/cm-vault/vault-install

WARNING: Are you sure you want to run `terragrunt destroy` in each folder of the stack described above? There is no undo! (y/n) y
```

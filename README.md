# Setup Cert-manager and Vault with the Terraform Helm provider

<!-- vscode-markdown-toc -->
* 1. [Goals](#Goals)
* 2. [Install `Helm`, `Terraform` and `Terragrunt`](#InstallHelmTerraformandTerragrunt)
	* 2.1. [Helm](#Helm)
	* 2.2. [Terraform](#Terraform)
	* 2.3. [Terragrunt](#Terragrunt)
* 3. [Usage Steps](#UsageSteps)
	* 3.1. [Configure Terraform Plugin Cache.](#ConfigureTerraformPluginCache.)
	* 3.2. [Execute `terragrunt run-all init`](#Executeterragruntrun-allinit)
	* 3.3. [Execute `terragrunt run-all apply`](#Executeterragruntrun-allapply)
	* 3.4. [View Deployment Results](#ViewDeploymentResults)
	* 3.5. [Check Status of `ClusterIssuer`](#CheckStatusofClusterIssuer)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

##  1. <a name='Goals'></a>Goals

1. Deploy and setup Cert-manager and Vault in test environment with Terraform.

2. Automate to configure Vault PKI Secrets Engine and Vault authentication.

3. Automate to create a ClusterIssuer that represents the certificate authority Vault.


##  2. <a name='InstallHelmTerraformandTerragrunt'></a>Install `Helm`, `Terraform` and `Terragrunt`

These all are open source softwares, you can directly install them by official documentation.

###  2.1. <a name='Helm'></a>Helm

Helm is the best way to find, share, and use software built for Kubernetes.

[Installing Helm](https://helm.sh/docs/intro/install/)

###  2.2. <a name='Terraform'></a>Terraform

Terraform is an IT infrastructure automation orchestration tool.

[Install Terraform](https://www.terraform.io/downloads)

###  2.3. <a name='Terragrunt'></a>Terragrunt

Terragrunt is a thin wrapper that provides extra tools for keeping your configurations DRY, working with multiple Terraform modules, and managing remote state.

[Install Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)

##  3. <a name='UsageSteps'></a>Usage Steps

###  3.1. <a name='ConfigureTerraformPluginCache.'></a>Configure Terraform Plugin Cache.

```
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache" 
```

###  3.2. <a name='Executeterragruntrun-allinit'></a>Execute `terragrunt run-all init`
```
[root@master68 terraform-cm]# terragrunt run-all init
INFO[0000] The stack at /root/lonelyCZ/terraform-cm will be processed in the following order for command init:
Group 1
- Module /root/lonelyCZ/terraform-cm/helm-release

Group 2
- Module /root/lonelyCZ/terraform-cm/vault-config

Group 3
- Module /root/lonelyCZ/terraform-cm/cert-manager-config
 

Initializing the backend...
```
<details>

<summary><font color=red>Click for more output details</font></summary>

```
Initializing provider plugins...
- Finding hashicorp/helm versions matching "~> 2.5.1"...
- Using hashicorp/helm v2.5.1 from the shared cache directory

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/vault versions matching "~> 3.5.0"...
- Using hashicorp/vault v3.5.0 from the shared cache directory

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/kubernetes versions matching "~> 2.11.0"...
- Using hashicorp/kubernetes v2.11.0 from the shared cache directory

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
</details>  


###  3.3. <a name='Executeterragruntrun-allapply'></a>Execute `terragrunt run-all apply`

```
[root@master68 terraform-cm]# terragrunt run-all apply
INFO[0000] The stack at /root/lonelyCZ/terraform-cm will be processed in the following order for command apply:
Group 1
- Module /root/lonelyCZ/terraform-cm/helm-release

Group 2
- Module /root/lonelyCZ/terraform-cm/vault-config

Group 3
- Module /root/lonelyCZ/terraform-cm/cert-manager-config
 
Are you sure you want to run 'terragrunt apply' in each folder of the stack described above? (y/n) y
```

<details>

<summary><font color=red>Click for more output details</font></summary>

```
Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # helm_release.cert-manager will be created
  + resource "helm_release" "cert-manager" {
      + atomic                     = false
      + chart                      = "cert-manager"
      + cleanup_on_fail            = false
      + create_namespace           = true
      + dependency_update          = false
      + disable_crd_hooks          = false
      + disable_openapi_validation = false
      + disable_webhooks           = false
      + force_update               = false
      + id                         = (known after apply)
      + lint                       = false
      + manifest                   = (known after apply)
      + max_history                = 0
      + metadata                   = (known after apply)
      + name                       = "cert-manager"
      + namespace                  = "cert-manager"
      + recreate_pods              = false
      + render_subchart_notes      = true
      + replace                    = false
      + repository                 = "https://charts.jetstack.io"
      + reset_values               = false
      + reuse_values               = false
      + skip_crds                  = false
      + status                     = "deployed"
      + timeout                    = 300
      + verify                     = false
      + version                    = "v1.8.0"
      + wait                       = true
      + wait_for_jobs              = false

      + set {
          + name  = "installCRDs"
          + value = "true"
        }
    }

  # helm_release.vault will be created
  + resource "helm_release" "vault" {
      + atomic                     = false
      + chart                      = "vault"
      + cleanup_on_fail            = false
      + create_namespace           = true
      + dependency_update          = false
      + disable_crd_hooks          = false
      + disable_openapi_validation = false
      + disable_webhooks           = false
      + force_update               = false
      + id                         = (known after apply)
      + lint                       = false
      + manifest                   = (known after apply)
      + max_history                = 0
      + metadata                   = (known after apply)
      + name                       = "vault"
      + namespace                  = "vault"
      + recreate_pods              = false
      + render_subchart_notes      = true
      + replace                    = false
      + repository                 = "https://helm.releases.hashicorp.com"
      + reset_values               = false
      + reuse_values               = false
      + skip_crds                  = false
      + status                     = "deployed"
      + timeout                    = 300
      + verify                     = false
      + version                    = "0.19.0"
      + wait                       = true
      + wait_for_jobs              = false

      + set {
          + name  = "server.dev.enabled"
          + value = "true"
        }
      + set {
          + name  = "server.service.nodePort"
          + value = "30200"
        }
      + set {
          + name  = "server.service.type"
          + value = "NodePort"
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.
helm_release.vault: Creating...
helm_release.cert-manager: Creating...
helm_release.vault: Still creating... [10s elapsed]
helm_release.cert-manager: Still creating... [10s elapsed]
helm_release.vault: Creation complete after 15s [id=vault]
helm_release.cert-manager: Still creating... [20s elapsed]
helm_release.cert-manager: Still creating... [30s elapsed]
helm_release.cert-manager: Still creating... [40s elapsed]
helm_release.cert-manager: Still creating... [50s elapsed]
helm_release.cert-manager: Still creating... [1m0s elapsed]
helm_release.cert-manager: Still creating... [1m10s elapsed]
helm_release.cert-manager: Still creating... [1m20s elapsed]
helm_release.cert-manager: Still creating... [1m30s elapsed]
helm_release.cert-manager: Creation complete after 1m38s [id=cert-manager]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # vault_mount.pki will be created
  + resource "vault_mount" "pki" {
      + accessor                     = (known after apply)
      + audit_non_hmac_request_keys  = (known after apply)
      + audit_non_hmac_response_keys = (known after apply)
      + default_lease_ttl_seconds    = (known after apply)
      + external_entropy_access      = false
      + id                           = (known after apply)
      + max_lease_ttl_seconds        = 31536000
      + path                         = "pki"
      + seal_wrap                    = (known after apply)
      + type                         = "pki"
    }

  # vault_pki_secret_backend_role.role will be created
  + resource "vault_pki_secret_backend_role" "role" {
      + allow_any_name                     = false
      + allow_bare_domains                 = false
      + allow_glob_domains                 = false
      + allow_ip_sans                      = true
      + allow_localhost                    = true
      + allow_subdomains                   = true
      + allowed_domains                    = [
          + "cert-manager.io",
        ]
      + allowed_domains_template           = false
      + backend                            = "pki"
      + basic_constraints_valid_for_non_ca = false
      + client_flag                        = true
      + code_signing_flag                  = false
      + email_protection_flag              = false
      + enforce_hostnames                  = true
      + generate_lease                     = false
      + id                                 = (known after apply)
      + key_bits                           = 2048
      + key_type                           = "rsa"
      + name                               = "cert-manager-io"
      + no_store                           = false
      + not_before_duration                = (known after apply)
      + require_cn                         = true
      + server_flag                        = true
      + ttl                                = "31536000"
      + use_csr_common_name                = true
      + use_csr_sans                       = true
    }

  # vault_pki_secret_backend_root_cert.ca will be created
  + resource "vault_pki_secret_backend_root_cert" "ca" {
      + backend              = "pki"
      + certificate          = (known after apply)
      + common_name          = "cert-manager.io"
      + exclude_cn_from_sans = true
      + format               = "pem"
      + id                   = (known after apply)
      + issuing_ca           = (known after apply)
      + key_bits             = 2048
      + key_type             = "rsa"
      + max_path_length      = -1
      + private_key_format   = "der"
      + serial               = (known after apply)
      + ttl                  = "31536000"
      + type                 = "internal"
    }

Plan: 3 to add, 0 to change, 0 to destroy.
vault_mount.pki: Creating...
vault_mount.pki: Creation complete after 0s [id=pki]
vault_pki_secret_backend_root_cert.ca: Creating...
vault_pki_secret_backend_role.role: Creating...
vault_pki_secret_backend_role.role: Creation complete after 0s [id=pki/roles/cert-manager-io]
vault_pki_secret_backend_root_cert.ca: Creation complete after 1s [id=pki/root/generate/internal]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # kubernetes_manifest.vault-issuer will be created
  + resource "kubernetes_manifest" "vault-issuer" {
      + manifest = {
          + apiVersion = "cert-manager.io/v1"
          + kind       = "ClusterIssuer"
          + metadata   = {
              + name = "vault-issuer"
            }
          + spec       = {
              + vault = {
                  + auth   = {
                      + tokenSecretRef = {
                          + key  = "token"
                          + name = "vault-token"
                        }
                    }
                  + path   = "pki/sign/example-dot-com"
                  + server = "http://vault.vault.svc:8200"
                }
            }
        }
      + object   = {
          + apiVersion = "cert-manager.io/v1"
          + kind       = "ClusterIssuer"
          + metadata   = {
              + annotations                = (known after apply)
              + clusterName                = (known after apply)
              + creationTimestamp          = (known after apply)
              + deletionGracePeriodSeconds = (known after apply)
              + deletionTimestamp          = (known after apply)
              + finalizers                 = (known after apply)
              + generateName               = (known after apply)
              + generation                 = (known after apply)
              + labels                     = (known after apply)
              + managedFields              = (known after apply)
              + name                       = "vault-issuer"
              + namespace                  = (known after apply)
              + ownerReferences            = (known after apply)
              + resourceVersion            = (known after apply)
              + selfLink                   = (known after apply)
              + uid                        = (known after apply)
            }
          + spec       = {
              + acme       = {
                  + disableAccountKeyGeneration = (known after apply)
                  + email                       = (known after apply)
                  + enableDurationFeature       = (known after apply)
                  + externalAccountBinding      = {
                      + keyAlgorithm = (known after apply)
                      + keyID        = (known after apply)
                      + keySecretRef = {
                          + key  = (known after apply)
                          + name = (known after apply)
                        }
                    }
                  + preferredChain              = (known after apply)
                  + privateKeySecretRef         = {
                      + key  = (known after apply)
                      + name = (known after apply)
                    }
                  + server                      = (known after apply)
                  + skipTLSVerify               = (known after apply)
                  + solvers                     = (known after apply)
                }
              + ca         = {
                  + crlDistributionPoints = (known after apply)
                  + ocspServers           = (known after apply)
                  + secretName            = (known after apply)
                }
              + selfSigned = {
                  + crlDistributionPoints = (known after apply)
                }
              + vault      = {
                  + auth      = {
                      + appRole        = {
                          + path      = (known after apply)
                          + roleId    = (known after apply)
                          + secretRef = {
                              + key  = (known after apply)
                              + name = (known after apply)
                            }
                        }
                      + kubernetes     = {
                          + mountPath = (known after apply)
                          + role      = (known after apply)
                          + secretRef = {
                              + key  = (known after apply)
                              + name = (known after apply)
                            }
                        }
                      + tokenSecretRef = {
                          + key  = "token"
                          + name = "vault-token"
                        }
                    }
                  + caBundle  = (known after apply)
                  + namespace = (known after apply)
                  + path      = "pki/sign/example-dot-com"
                  + server    = "http://vault.vault.svc:8200"
                }
              + venafi     = {
                  + cloud = {
                      + apiTokenSecretRef = {
                          + key  = (known after apply)
                          + name = (known after apply)
                        }
                      + url               = (known after apply)
                    }
                  + tpp   = {
                      + caBundle       = (known after apply)
                      + credentialsRef = {
                          + name = (known after apply)
                        }
                      + url            = (known after apply)
                    }
                  + zone  = (known after apply)
                }
            }
        }
    }

  # kubernetes_secret_v1.vault-token will be created
  + resource "kubernetes_secret_v1" "vault-token" {
      + data = (sensitive value)
      + id   = (known after apply)
      + type = "opaque"

      + metadata {
          + generation       = (known after apply)
          + name             = "vault-token"
          + namespace        = "cert-manager"
          + resource_version = (known after apply)
          + uid              = (known after apply)
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.
kubernetes_secret_v1.vault-token: Creating...
kubernetes_secret_v1.vault-token: Creation complete after 0s [id=cert-manager/vault-token]
kubernetes_manifest.vault-issuer: Creating...
kubernetes_manifest.vault-issuer: Creation complete after 1s

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```
</details>

###  3.4. <a name='ViewDeploymentResults'></a>View Deployment Results

```
[root@master68 terraform-cm]# kubectl get pod -A
NAMESPACE        NAME                                      READY   STATUS    RESTARTS        AGE
cert-manager     cert-manager-6bbf595697-6dvpz             1/1     Running   0               3m41s
cert-manager     cert-manager-cainjector-6bc9d758b-6qq7b   1/1     Running   0               3m41s
cert-manager     cert-manager-webhook-586d45d5ff-s8ql9     1/1     Running   0               3m41s
default          nginx-6799fc88d8-tn5wx                    2/2     Running   0               9d
karmada-system   karmada-agent-57994899b-4xg77             1/1     Running   30 (6d6h ago)   10d
karmada-system   karmada-agent-57994899b-c77sm             1/1     Running   4 (6d6h ago)    10d
kube-system      coredns-7f6cbbb7b8-77wjk                  1/1     Running   9 (10d ago)     155d
kube-system      coredns-7f6cbbb7b8-hhp8x                  1/1     Running   9 (10d ago)     155d
kube-system      etcd-master68                             1/1     Running   4 (10d ago)     44d
kube-system      kube-apiserver-master68                   1/1     Running   5 (10d ago)     44d
kube-system      kube-controller-manager-master68          1/1     Running   55 (10d ago)    44d
kube-system      kube-flannel-ds-4zh8n                     1/1     Running   6 (26d ago)     61d
kube-system      kube-flannel-ds-9w82j                     1/1     Running   13 (10d ago)    155d
kube-system      kube-proxy-hc8mk                          1/1     Running   4 (26d ago)     61d
kube-system      kube-proxy-hp966                          1/1     Running   10 (10d ago)    166d
kube-system      kube-scheduler-master68                   1/1     Running   52 (10d ago)    44d
vault            vault-0                                   1/1     Running   0               3m53s
vault            vault-agent-injector-6cd49f8bbd-vq74f     1/1     Running   0               3m53s
```

###  3.5. <a name='CheckStatusofClusterIssuer'></a>Check Status of `ClusterIssuer`

```
[root@master68 terraform-cm]# kubectl get clusterissuers -o wide
NAME           READY   STATUS           AGE
vault-issuer   True    Vault verified   3m24s
```
terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.5.1"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

# deploy vault
resource "helm_release" "vault" {
  name       = "vault"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  namespace        = "vault"
  create_namespace = true

  set {
    # This installs a single Vault server with a memory storage backend.
    name  = "server.dev.enabled"
    value = "true"
  }

  set {
    name = "server.service.type"
    value = "NodePort"
  }

  set {
    name = "server.service.nodePort"
    value = "30200"
  }
}

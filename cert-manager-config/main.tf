terraform {
  required_providers {
    kubernetes = {
        source  = "hashicorp/kubernetes"
        version = "~> 2.11.0"
    }
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

resource "kubernetes_secret_v1" "vault-token" {
  metadata {
    name = "vault-token"
    namespace = "cert-manager"
  }
  data = {
    token = "root"
  }
  type = "opaque"
}

resource "kubernetes_manifest" "vault-issuer" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = "vault-issuer"
    }
    "spec" = {
      "vault" = {
        "auth" = {
          "tokenSecretRef" = {
            "key"  = "token"
            "name" = "${kubernetes_secret_v1.vault-token.metadata[0].name}"
          }
        }
        "path"   = "pki/sign/example-dot-com"
        "server" = "http://vault.vault.svc:8200"
      }
    }
  }
}

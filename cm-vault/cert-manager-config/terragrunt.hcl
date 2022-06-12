dependency "helm_release" {
    config_path = "../helm-release"

    skip_outputs = "true"
}

dependency "vault-config" {
    config_path = "../vault-config"

    skip_outputs = "true"
}


locals {
  dns_secret_name = "dns-resolver-secret"
  webhook_group_name = "acme.farhand.me"
  hetzner_api_url = "https://dns.hetzner.com/api/v1"
  cert_manager_namespace = "cert-manager"

}


// Cert-manager

resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        =  local.cert_manager_namespace
  version          = "1.4.0-alpha.1"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }
}

// Cluster Issuer

resource "null_resource" "cert_manager_issuer" {
  provisioner "local-exec" {
    command = " kubectl --kubeconfig ${var.k3s_config_file} apply -f -<<EOF\n${data.template_file.cluster_issuer.rendered}\nEOF"
  }
  depends_on = [helm_release.cert_manager]
}

data "template_file" "cluster_issuer" {
  template = file("${path.module}/manifests/clusterIssuer.yaml")
  vars = {
    acme_email       = var.issuer_email
    issuer_name = "${var.cluster_issuer_name}-${var.letsencrypt_is_prod ? "prod":"stage"}"
    server      = var.letsencrypt_is_prod ? "https://acme-v02.api.letsencrypt.org/directory" : "https://acme-staging-v02.api.letsencrypt.org/directory"
    solver_type = var.cert_manager_solver_type

    zoneName    = "${var.default_domain}." //adding the trailing dot
    groupName   = local.webhook_group_name
    hetzner_api_url = local.hetzner_api_url
    dns_secret_name = local.dns_secret_name

    cloudflare_email = var.cloud_flare_api_email

  }
}


// Cert-Manager Webhook

resource "helm_release" "cert_manager_webhook" {
  count = var.cert_manager_solver_type == "DNS01_HETZNER" ? 1 : 0
  repository = "https://deyaeddin.github.io/cert-manager-webhook-hetzner/chart/"
  chart = "cert-manager-webhook-hetzner"
  name = "cert-manager-webhook-hetzner"
  namespace        = local.cert_manager_namespace
  version          = "0.1.10"

  values = [
    templatefile("${path.module}/hetznerWebhookValues.yaml", {
      groupName = local.webhook_group_name
      namespace = local.cert_manager_namespace
      secretName = local.dns_secret_name
    })
  ]

  depends_on = [helm_release.cert_manager]
}

resource "kubernetes_secret" "cert_manager_webhook_secrets" {
  count = var.cert_manager_solver_type == "HTTP01" ? 0 : 1
  metadata {
    name = local.dns_secret_name
    namespace = local.cert_manager_namespace
  }
  data = {
    "api-key" = var.cert_manager_solver_type == "DNS01_CLOUDFLARE" ? var.cloud_flare_api_key: var.hcloud_dns_api_token
  }
  type = "kubernetes.io/Opaque"
  depends_on = [helm_release.cert_manager]
}

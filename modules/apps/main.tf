module "default_backend" {
  source = "./default-backend"
  cluster_issuer_name = var.cluster_issuer_name
  letsencrypt_is_prod = var.letsencrypt_is_prod
  default_domain = var.default_domain
  nginx_default_backend = var.nginx_default_backend
  default_namespace = var.default_namespace

  depends_on = [null_resource.helm_updater]
}

module "octant" {
  source = "./octant"
  cluster_issuer_name = var.cluster_issuer_name
  letsencrypt_is_prod = var.letsencrypt_is_prod
  default_domain = var.default_domain
  default_namespace = var.default_namespace

  depends_on = [null_resource.helm_updater]
}


module "nginx_ingress_controller" {
  source                = "./nginx-ingress-controller"
  default_domain        = var.default_domain
  lb_hcloud_location    = var.lb_hcloud_location
  lb_hcloud_protocol    = var.lb_hcloud_protocol
  nginx_default_backend = var.nginx_default_backend
  default_namespace = var.default_namespace
  lb_hcloud_name        = var.lb_hcloud_name

  // we need the default backend service to be operated
  // so the loadbalancer become healthy
  depends_on = [module.default_backend]
}

module "external_dns" {
  source                  = "./external-dns"
  dns_provider            = var.dns_provider
  k3s_config_file         = var.k3s_config_file
  cluster_name            = var.cluster_name
  hcloud_dns_api_token    =  var.hcloud_dns_api_token

  cloud_flare_api_email   = var.cloud_flare_api_email
  cloud_flare_api_key     = var.cloud_flare_api_key
  cloud_flare_api_proxied = var.cloud_flare_api_proxied
  cloud_flare_api_token   = var.cloud_flare_api_token

}



module "cert_manager" {
  source = "./cert-manager"

  k3s_config_file     = var.k3s_config_file
  cluster_issuer_name = var.cluster_issuer_name
  letsencrypt_is_prod = var.letsencrypt_is_prod
  issuer_email        = var.issuer_email
  cert_manager_solver_type = var.cert_manager_solver_type

  default_domain      = var.default_domain

  cloud_flare_api_key = var.cloud_flare_api_key
  cloud_flare_api_email = var.cloud_flare_api_email

  hcloud_dns_api_token = var.hcloud_dns_api_token

  # we need dns to be populated for DNS01 challenge
  depends_on = [module.external_dns]

}


module "minio_gateway" {

  source = "./minio-gateway"
  default_domain = var.default_domain
  default_namespace = var.default_namespace
  cluster_issuer_name = var.cluster_issuer_name
  letsencrypt_is_prod = var.letsencrypt_is_prod

  # we need issuing certificates
  depends_on = [module.cert_manager]
}



module "minio_ops" {

  source = "./minio-ops"
  k3s_config_file       = var.k3s_config_file
  default_domain        = var.default_domain
  default_namespace     = var.default_namespace
  storage_class         = var.storage_class
  # we need issuing certificates
  depends_on = [module.cert_manager]
}
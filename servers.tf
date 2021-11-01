provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_network" "private" {
  name     = var.cluster_name
  ip_range = "10.0.0.0/8"
}

resource "hcloud_network_subnet" "subnet" {
  network_id   = hcloud_network.private.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = "10.0.0.0/24"
}

resource "random_string" "k3s_token" {
  length  = 48
  upper   = false
  special = false
}

module "master" {
  source = "./modules/master"

  cluster_name = var.cluster_name
  datacenter   = var.datacenter
  image        = var.image
  node_type    = var.master_type
  ssh_keys     = var.ssh_keys

  hcloud_network_id = hcloud_network.private.id
  hcloud_subnet_id  = hcloud_network_subnet.subnet.id

  k3s_token   = random_string.k3s_token.result
  k3s_channel = var.k3s_channel

  hcloud_token = var.hcloud_token
}

module "node_group" {
  source       = "./modules/node_group"
  cluster_name = var.cluster_name
  datacenter   = var.datacenter
  image        = var.image
  ssh_keys     = var.ssh_keys
  master_ipv4  = module.master.master_ipv4

  hcloud_subnet_id = hcloud_network_subnet.subnet.id

  k3s_token   = random_string.k3s_token.result
  k3s_channel = var.k3s_channel

  for_each   = var.node_groups
  node_type  = each.key
  node_count = each.value
}

module "kubeconfig" {
  source       = "./modules/kubeconfig"
  cluster_name = var.cluster_name
  master_ipv4  = module.master.master_ipv4
}

module "apps" {
  source                   = "./modules/apps"
  cluster_name             = var.cluster_name
  k3s_config_file          = var.k3s_config_file
  cluster_issuer_name      = var.cluster_issuer_name
  letsencrypt_is_prod      = var.letsencrypt_is_prod
  issuer_email             = var.issuer_email
  cert_manager_solver_type = var.cert_manager_solver_type
  hcloud_dns_api_token     = var.hcloud_dns_api_token
  default_domain           = var.default_domain
  lb_hcloud_location       = var.lb_hcloud_location
  lb_hcloud_name           = var.lb_hcloud_name
  lb_hcloud_protocol       = var.lb_hcloud_protocol
  nginx_default_backend    = var.nginx_default_backend
  default_namespace        = var.default_namespace
  dns_provider             = var.dns_provider
  cloud_flare_api_email    = var.cloudflare_email
  cloud_flare_api_key      = var.cloudflare_api_key
  cloud_flare_api_proxied  = var.cloud_flare_api_proxied
  cloud_flare_api_token    = var.cloudflare_api_token
  storage_class            = var.storage_class
  depends_on               = [module.master]
}

# # cluster 1
# module "cluster" {
#   source       = "cicdteam/k3s/hcloud"
#   version      = "0.1.2"
#   hcloud_token = var.hcloud_token
#   ssh_keys     = ["nuc", "mac"]
#   datacenter   = "nbg1-dc3"
#   cluster_name = "k8s"
#   image        = "ubuntu-20.04"
#   k3s_channel  = "v1.21"
#   master_type  = "cx21"
#   node_groups  = {
#     "cx21" = 2
#   }
# }

# # network output
# output "master_ipv4" {
#   depends_on  = [module.cluster]
#   description = "Public IP Address of the master node"
#   value       = module.cluster.master_ipv4
# }

# output "nodes_ipv4" {
#   depends_on  = [module.cluster]
#   description = "Public IP Address of the worker nodes"
#   value       = module.cluster.nodes_ipv4
# }


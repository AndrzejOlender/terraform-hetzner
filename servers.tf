# cluster 1
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

# cluster 1
module "k3s-ext" {
  source                       = "deyaeddin/k3s-ext/hcloud"
  version                      = "0.0.1"
  cloud_flare_api_email        = var.cloudflare_email
  cloud_flare_api_key          = var.cloudflare_api_key
  cloud_flare_api_token        = var.cloudflare_api_token
  default_domain               = "olender.io"
  hcloud_dns_api_token         = ""
  hcloud_masters_extra_scripts = []
  hcloud_node_extra_scripts    = []
  hcloud_token                 = var.hcloud_token
  issuer_email                 = var.cloudflare_email
  enable_apps                  = true
  public_key_path              = file(var.ssh_mac)

  //optional
  k3s_version         = "v1.21.1+k3s1" //"v1.19.11+k3s1" "v1.20.7+k3s1" "v1.21.1+k3s1"
  master_groups_type  = "cx21"         # 2 vCPU, 4 GB RAM, 40 GB Disk space
  master_groups_count = 1              // Odd number for HA enabled
  node_groups = {                      // NOTE: pass emtpy map to use a single master
    "cx21" = 1
    "cx21" = 1
  }
}

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


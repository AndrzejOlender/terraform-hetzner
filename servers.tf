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
  ssh_keys     = ["nuc", "mac"]

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
  ssh_keys     = ["nuc", "mac"]
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

output "master_ipv4" {
  depends_on  = [module.master]
  description = "Public IP Address of the master node"
  value       = module.master.master_ipv4
}

output "nodes_ipv4" {
  depends_on  = [module.node_group]
  description = "Public IP Address of the worker nodes in groups"
  value = {
    for type, n in module.node_group :
    type => n.node_ipv4
  }
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


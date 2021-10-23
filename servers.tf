# cluster 1
module "cluster" {
  source       = "cicdteam/k3s/hcloud"
  version      = "0.1.2"
  hcloud_token = var.hcloud_token
  ssh_keys     = ["nuc", "mac"]
  datacenter   = "nbg1-dc3"
  cluster_name = "k8s"
  image        = "ubuntu-20.04"
  k3s_channel  = "v1.21-1"
  master_type  = "cx21"
  node_groups  = {
    "cx21" = 1
  }
}

output "master_ipv4" {
  depends_on  = [module.cluster]
  description = "Public IP Address of the master node"
  value       = module.cluster.master_ipv4
}

output "nodes_ipv4" {
  depends_on  = [module.cluster]
  description = "Public IP Address of the worker nodes"
  value       = module.cluster.nodes_ipv4
}

# cluster 2
module "cluster" {
  source       = "cicdteam/k3s/hcloud"
  version      = "0.1.2"
  hcloud_token = var.hcloud_token
  ssh_keys     = ["nuc", "mac"]
  datacenter   = "nbg1-dc3"
  cluster_name = "k8s-2"
  image        = "ubuntu-20.04"
  k3s_channel  = "v1.21"
  master_type  = "cx21"
  node_groups  = {
    "cx21" = 1
  }
}

output "master_ipv4" {
  depends_on  = [module.cluster]
  description = "Public IP Address of the master node"
  value       = module.cluster.master_ipv4
}

output "nodes_ipv4" {
  depends_on  = [module.cluster]
  description = "Public IP Address of the worker nodes"
  value       = module.cluster.nodes_ipv4
}

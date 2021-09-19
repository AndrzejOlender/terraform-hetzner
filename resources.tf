# resource "hcloud_server" "node1" {
#   name        = "node1"
#   server_type = "cx21"
#   datacenter  = data.hcloud_datacenter.ds.name
#   image       = "ubuntu-20.04"
#   ssh_keys    = ["nuc", "mac"]
#   provisioner "remote-exec" {
#     inline = [
#       "curl -sLS https://get.k3sup.dev | sh",
#       "sudo install k3sup /usr/local/bin/"
#     ]
#     connection {
#       type     = "ssh"
#       host     = hcloud_server.node1.ipv4_address
#       user     = var.ssh_user
#       password = var.ssh_password
#     }
#   }
# }

# resource "hcloud_server" "node2" {
#   name        = "node2"
#   server_type = "cx21"
#   datacenter  = data.hcloud_datacenter.ds.name
#   image       = "ubuntu-20.04"
#   ssh_keys    = ["nuc", "mac"]
#   provisioner "remote-exec" {
#     inline = [
#       "curl -sLS https://get.k3sup.dev | sh",
#       "sudo install k3sup /usr/local/bin/"
#     ]
#     connection {
#       type     = "ssh"
#       host     = hcloud_server.node2.ipv4_address
#       user     = var.ssh_user
#       password = var.ssh_password
#     }
#   }
# }

# resource "hcloud_server" "node3" {
#   name        = "node3"
#   server_type = "cx21"
#   datacenter  = data.hcloud_datacenter.ds.name
#   image       = "ubuntu-20.04"
#   ssh_keys    = ["nuc", "mac"]
#   provisioner "remote-exec" {
#     inline = [
#       "curl -sLS https://get.k3sup.dev | sh",
#       "sudo install k3sup /usr/local/bin/"
#     ]
#     connection {
#       type     = "ssh"
#       host     = hcloud_server.node3.ipv4_address
#       user     = var.ssh_user
#       password = var.ssh_password
#     }
#   }
# }

module "cluster" {
  source       = "cicdteam/k3s/hcloud"
  version      = "0.1.2"
  hcloud_token = var.hcloud_token
  ssh_keys     = ["nuc", "mac"]
  datacenter   = "nbg1-dc3"
  cluster_name = "k8s"
  image        = "ubuntu-20.04"
  k3s_channel = "v1.21"

  master_type = "cx21"
  node_groups = {
    "cx21" = 4
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


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

# module "k8s" {
#   source  = "tibordp/dualstack-k8s/hcloud"
#   version = "0.6.4"

#   name               = "k8s"
#   hcloud_ssh_key     = hcloud_ssh_key.nuc.id
#   hcloud_token       = var.hetzner_token
#   location           = "hel1"
#   master_server_type = "cx21"
#   worker_server_type = "cx21"
#   worker_count       = 2

#   kubernetes_version = "1.22.0"
# }

# output "kubeconfig" {
#   value = module.k8s.kubeconfig
# }

module "cluster" {
  source  = "cicdteam/k3s/hcloud"
  version = "0.1.1"
  hcloud_token = var.hcloud_token
  ssh_keys = [hcloud_ssh_key.nuc.id]
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

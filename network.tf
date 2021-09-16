# resource "hcloud_network" "k8s" {
#   name     = "k8s"
#   ip_range = "10.0.0.0/8"
# }

# resource "hcloud_network_subnet" "k8s" {
#   network_id   = hcloud_network.k8s.id
#   type         = "cloud"
#   network_zone = "eu-central"
#   ip_range     = "10.0.1.0/24"
# }

# resource "hcloud_server_network" "node1" {
#   server_id  = hcloud_server.node1.id
#   network_id = hcloud_network.k8s.id
#   ip         = "10.0.1.11"
# }

# resource "hcloud_server_network" "node2" {
#   server_id  = hcloud_server.node2.id
#   network_id = hcloud_network.k8s.id
#   ip         = "10.0.1.12"
# }

# resource "hcloud_server_network" "node3" {
#   server_id  = hcloud_server.node3.id
#   network_id = hcloud_network.k8s.id
#   ip         = "10.0.1.13"
# }

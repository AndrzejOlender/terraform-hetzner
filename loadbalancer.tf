# resource "hcloud_load_balancer" "k8s" {
#   name       = "k8s"
#   load_balancer_type = "lb11"
#   location   = "nbg1"
#   algorithm {
#     type = "round_robin"
#   }
#   target {
#     type = "server"
#     server_id = hcloud_server.node1.id
#   }
#     target {
#     type = "server"
#     server_id = hcloud_server.node2.id
#   }
# }

# resource "hcloud_load_balancer_network" "k8s" {
#   load_balancer_id = hcloud_load_balancer.k8s.id
#   network_id = hcloud_network.k8s.id
#   ip = "10.0.1.6"
# }


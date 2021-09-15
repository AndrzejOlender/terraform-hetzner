# resource "hcloud_volume" "master" {
#   name      = "volume1"
#   size      = 50
#   format    = "xfs"
#   server_id = hcloud_server.node1.id
#   automount = false
# }

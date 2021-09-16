# data "hcloud_image" "ubuntu" {
#   id = "15512617"
# }

resource "hcloud_server" "node1" {
  name        = "node1"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = "ubuntu-20.04"
  ssh_keys    = ["nuc","mac"]
  provisioner "remote-exec" {
    inline = [
      "curl -sLS https://get.k3sup.dev | sh",
      "sudo install k3sup /usr/local/bin/",
    ]
  }

resource "hcloud_server" "node2" {
  name        = "node2"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = "ubuntu-20.04"
  ssh_keys    = ["nuc","mac"]
}

resource "hcloud_server" "node3" {
  name        = "node3"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = "ubuntu-20.04"
  ssh_keys    = ["nuc","mac"]
}

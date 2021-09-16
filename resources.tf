# hcloud
data "hcloud_image" "k3os" {
  id = "48035117"
}
resource "hcloud_server" "node1" {
  name        = "node1"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = "ubuntu-20.04"
  ssh_keys    = ["nuc"]
}

resource "hcloud_server" "node2" {
  name        = "node2"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = "ubuntu-20.04"
  ssh_keys    = ["nuc"]
}

resource "hcloud_server" "node3" {
  name        = "node3"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = "ubuntu-20.04"
  ssh_keys    = ["nuc"]
}

resource "hcloud_server" "main" {
  image = data.hcloud_image.image_1.name
}

resource "hcloud_server" "k3os" {
  name        = "k3os"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  ssh_keys    = ["nuc"]
}

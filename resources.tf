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

data "hcloud_image" "image_1" {
  id = "48035117"
}

resource "hcloud_server" "main" {
  name        = "main"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image = data.hcloud_image.image_1.id
  ssh_keys    = ["nuc"]
}

# hcloud
data "hcloud_image" "k3os" {
  id = "37004880"
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

resource "hcloud_server" "k3os" {
  name        = "k3os"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = data.hcloud_image.k3os.name
  ssh_keys    = ["nuc"]
}

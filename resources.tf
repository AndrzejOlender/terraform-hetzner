data "hcloud_image" "k3os" {
  id = "48035117"
}

resource "hcloud_server" "node1" {
  name        = "node1"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = data.hcloud_image.k3os.id
  ssh_keys    = ["nuc,mac"]
}

resource "hcloud_server" "node2" {
  name        = "node2"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = data.hcloud_image.k3os.id
  ssh_keys    = ["nuc,mac"]
}

resource "hcloud_server" "node3" {
  name        = "node3"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = data.hcloud_image.k3os.id
  ssh_keys    = ["nuc,mac"]
}

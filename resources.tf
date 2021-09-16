data "hcloud_image" "ubuntu" {
  id = "15512617"
}

resource "hcloud_server" "node1" {
  name        = "node1"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = data.hcloud_image.ubuntu.id
  ssh_keys    = ["nuc","mac"]
  provisioner "local-exec" {
    command = <<-EOT
    bash echo "test" > /test.txt
        EOT
  }
}

resource "hcloud_server" "node2" {
  name        = "node2"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = data.hcloud_image.ubuntu.id
  ssh_keys    = ["nuc","mac"]
}

resource "hcloud_server" "node3" {
  name        = "node3"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = data.hcloud_image.ubuntu.id
  ssh_keys    = ["nuc","mac"]
}

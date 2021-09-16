# data "hcloud_image" "ubuntu" {
#   id = "15512617"
# }

resource "hcloud_server" "node1" {
  name        = "node1"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = "ubuntu-20.04"
  ssh_keys    = ["nuc","mac"]
  provisioner "file" {
    source      = "script/bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "/tmp/bootstrap.sh args",
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

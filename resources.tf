resource "hcloud_server" "node1" {
  name        = "node1"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = "ubuntu-20.04"
  ssh_keys    = ["nuc", "mac"]
  provisioner "remote-exec" {
    inline = [
      "curl -sLS https://get.k3sup.dev | sh",
      "sudo install k3sup /usr/local/bin/"
    ]
    connection {
      type     = "ssh"
      host     = hcloud_server.node1.ipv4_address
      user     = var.ssh_user
      password = var.ssh_password
    }
  }
}

resource "hcloud_server" "node2" {
  name        = "node2"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = "ubuntu-20.04"
  ssh_keys    = ["nuc", "mac"]
  provisioner "remote-exec" {
    inline = [
      "curl -sLS https://get.k3sup.dev | sh",
      "sudo install k3sup /usr/local/bin/"
    ]
    connection {
      type     = "ssh"
      host     = hcloud_server.node2.ipv4_address
      user     = var.ssh_user
      password = var.ssh_password
    }
  }
}

resource "hcloud_server" "node3" {
  name        = "node3"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = "ubuntu-20.04"
  ssh_keys    = ["nuc", "mac"]
  provisioner "remote-exec" {
    inline = [
      "curl -sLS https://get.k3sup.dev | sh",
      "sudo install k3sup /usr/local/bin/"
    ]
    connection {
      type     = "ssh"
      host     = hcloud_server.node3.ipv4_address
      user     = var.ssh_user
      password = var.ssh_password
    }
  }
}
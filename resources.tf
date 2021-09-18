resource "hcloud_server" "node1" {
  name        = "node1"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = "ubuntu-20.04"
  ssh_keys    = ["nuc","mac"]
  provisioner "remote-exec" {
    inline = [
      "echo ${var.ssh_user} > /user.txt"
    ]
    connection {
      type        = "ssh"
      host        = "168.119.224.111"
      user        = var.ssh_user
      password    = var.ssh_password
    }
  }
}

resource "hcloud_server" "node2" {
  name        = "node2"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = "ubuntu-20.04"
  ssh_keys    = ["nuc","mac"]
  provisioner "remote-exec" {
    inline = [
      "echo ${var.ssh_user} > /user.txt"
    ]
    connection {
      type        = "ssh"
      host        = "168.119.224.111"
      user        = var.ssh_user
      password    = var.ssh_password
    }
  }
}

resource "hcloud_server" "node3" {
  name        = "node3"
  server_type = "cx21"
  datacenter  = data.hcloud_datacenter.ds.name
  image       = "ubuntu-20.04"
  ssh_keys    = ["nuc","mac"]
  provisioner "remote-exec" {
    inline = [
      "echo ${var.ssh_user} > /user.txt"
    ]
    connection {
      type        = "ssh"
      host        = "168.119.224.111"
      user        = var.ssh_user
      password    = var.ssh_password
    }
  }
}
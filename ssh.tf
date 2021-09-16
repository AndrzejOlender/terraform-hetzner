variable "ssh" {
  type = string
}

variable "ssh-mac" {
  type = string
}

resource "hcloud_ssh_key" "nuc" {
  name       = "nuc"
  public_key = var.ssh
} 

resource "hcloud_ssh_key" "mac" {
  name       = "mac"
  public_key = var.ssh-mac
} 

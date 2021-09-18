variable "ssh" {
  type = string
}


resource "hcloud_ssh_key" "nuc" {
  name       = "nuc"
  public_key = var.ssh
} 

variable "ssh-mac" {
  type = string
}

resource "hcloud_ssh_key" "mac" {
  name       = "mac"
  public_key = var.ssh-mac
} 

variable "ssh-password" {
  type        = string
  sensitive   = true
}


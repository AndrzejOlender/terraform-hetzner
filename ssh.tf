variable "ssh_nuc" {
  type = string
}

resource "hcloud_ssh_key" "nuc" {
  name       = "nuc"
  public_key = var.ssh_nuc
} 

variable "ssh_mac" {
  type = string
}

resource "hcloud_ssh_key" "mac" {
  name       = "mac"
  public_key = var.ssh_mac
} 

variable "ssh_password" {
  type        = string
  sensitive   = true
}


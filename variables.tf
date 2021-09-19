variable "ssh_nuc" {
  type = string
}

variable "ssh_mac" {
  type = string
}

variable "ssh_password" {
  type      = string
  sensitive = true
}

variable "ssh_user" {
  type      = string
  sensitive = true
}

variable "hetzner_token" {
  type = string
}

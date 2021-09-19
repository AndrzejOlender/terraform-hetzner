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

variable "hcloud_token" {
  type = string
}

variable "node_groups" {
  description = "Map of worker node groups, key is server_type, value is count of nodes in group"
  type        = map(string)
  default = {
    "cx21" = 2
  }
}
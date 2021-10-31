variable "ssh_nuc" {
  type = string
}

variable "ssh_mac" {
  type = string
}

variable "hcloud_token" {
  type = string
}

variable "cluster_name" {
  description = "Cluster name (prefix for all resource names)"
  default     = "k8s"
}

variable "datacenter" {
  description = "Hetzner datacenter where resources resides, hel1-dc2 (Helsinki 1 DC 2) or fsn1-dc14 (Falkenstein 1 DC14)"
  default     = "nbg1-dc3"
}

variable "image" {
  description = "Node boot image"
  default     = "ubuntu-20.04"
}

variable "master_type" {
  description = "Master node type (size)"
  default     = "cx21" # 2 vCPU, 4 GB RAM, 40 GB Disk space
}

variable "ssh_keys" {
  type        = list
  description = "List of public ssh_key ids"
  default     = ["nuc", "mac"]
}

variable "k3s_channel" {
  default = "v1.21"
}

variable "node_groups" {
  description = "Map of worker node groups, key is server_type, value is count of nodes in group"
  type        = map(string)
  default = {
    "cx21" = 1
  }
}
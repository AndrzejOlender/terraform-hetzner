variable "ssh_nuc" {
  type = string
}

variable "ssh_mac" {
  type = string
}

variable "hcloud_token" {
  type = string
}

variable "cloudflare_email" {
  type = string
}

variable "cloudflare_api_key" {
  type = string
}

variable "cloudflare_api_token" {
  type = string
}

variable "issuer_email" {
  description = "email for issuing certificates with LetsEncrypt"
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
  type        = list(any)
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
    "cx21" = 2
  }
}

variable "k3s_config_file" {
  description = "String path to config file"
  default     = "~/.kubeconfig/hetzner.config"
}

variable "cluster_issuer_name" {
  description = "name for cert-manager cluster issuer"
  default     = "letsencrypt"
}

variable "issuer_email" {
  description = "email for issuing certificates with LetsEncrypt"
}

variable "letsencrypt_is_prod" {
  type        = bool
  description = "wither to utilize the staging or production for Letsencrypt certificates issuing"
  default     = true
}

variable "cert_manager_solver_type" {
  description = "which solver cert-manger will use, values : HTTP01, DNS01_CLOUDFLARE, DNS01_HETZNER"
  default = "HTTP01"
}

variable "hcloud_dns_api_token" {
  description = "hashed Hetzner DNS access token"
  sensitive = true
}

variable "default_domain" {
  description = "root domain for ingress default service"
}

variable "lb_hcloud_location" {
  description = "location of the loadbalancer"
  default = "nbg1-dc3"
}

variable "lb_hcloud_name" {
  description = "name of the loadbalancer"
  default = "name_cluster_lb"
}

variable "lb_hcloud_protocol" {
  description = "protocol for the loadbalancer"
  default = "tcp"
}

variable "nginx_default_backend" {
  description = "nginx ingress controller default backend service name"
  default = "default-backend"
}

variable "default_namespace" {
  description = "default applications namespace"
  default = "apps"
}

variable "dns_provider" {
  description = "DNS provider to use. Values can be hetzner or cloudflare"
  default = "cloudflare"
}

variable "cloud_flare_api_proxied" {
  description = "wither the zone will be proxied on cloudflare "
  default = false
}

variable "storage_class" {
  description = "storage class to use with minio drivers"
  default = "hcloud-volumes"
}
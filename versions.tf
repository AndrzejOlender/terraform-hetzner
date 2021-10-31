# terraform {
#   required_providers {
#     hcloud = {
#       source  = "hetznercloud/hcloud"
#       version = "1.26.2"
#     }
#   }
#   backend "remote" {
#     organization = "olender"
#     workspaces {
#       name = "terraform-hetzner"
#     }
#   }
# }

terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
    local = {
      source = "hashicorp/local"
    }
    random = {
      source = "hashicorp/random"
    }
    template = {
      source = "hashicorp/template"
    }
  }
  required_version = ">= 0.12"
  backend "remote" {
    organization = "olender"
    workspaces {
      name = "terraform-hetzner"
    }
  }
}
terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.26.2"
    }
  }
  backend "remote" {
    organization = "olender"

    workspaces {
      name = "terraform-hetzner"
    }
  }
}

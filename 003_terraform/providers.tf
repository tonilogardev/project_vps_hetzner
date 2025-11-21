terraform {
  required_version = ">= 1.5.0"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
    hetznerdns = {
      source  = "timohirt/hetznerdns"
      version = ">= 2.0, < 3.0"
    }
  }
}

provider "hcloud" {
  token = var.HETZNER_CLOUD_TOKEN
}

provider "hetznerdns" {
  apitoken = var.HETZNER_DNS_TOKEN
}

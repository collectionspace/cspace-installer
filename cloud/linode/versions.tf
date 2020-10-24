terraform {
  required_providers {
    linode = {
      source = "linode/linode"
    }
    local = {
      source = "hashicorp/local"
    }
  }
  required_version = ">= 0.13"
}

# VARIABLES
variable "authorized_key" { default = "~/.ssh/id_rsa.pub" }
variable "authorized_user" { default = "deploy" }
variable "backups_enabled" { default = false }
variable "instance_type" { default = "g6-standard-2" }
variable "root_pass" {}
variable "region" { default = "us-central" }
variable "token" {}

# VERSION
terraform {
  required_version = "~> 0.12.1"
}

# PROVIDER
provider "linode" {
  token = var.token
}

data "local_file" "public_key" {
  filename = pathexpand(var.authorized_key)
}

# RESOURCES
resource "linode_instance" "collectionspace" {
  authorized_keys = [trimspace(data.local_file.public_key.content)]
  backups_enabled = var.backups_enabled
  group = "collectionspace"
  image = "linode/ubuntu18.04"
  label = "collectionspace"
  region = var.region
  root_pass = var.root_pass
  swap_size = 1024
  tags = ["collectionspace"]
  type = var.instance_type
}

output "ip_address" {
  value = linode_instance.collectionspace.ip_address
}

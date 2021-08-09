# VARIABLES
variable "authorized_key" { default = "~/.ssh/id_rsa.pub" }
variable "backups_enabled" { default = false }
variable "image" { default = "linode/ubuntu21.04" }
variable "instance_type" { default = "g6-standard-2" }
variable "root_pass" {}
variable "region" { default = "us-central" }
variable "token" {}

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
  image = var.image
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

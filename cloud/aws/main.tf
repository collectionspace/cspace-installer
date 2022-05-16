# VARIABLES
variable "authorized_key" { default = "~/.ssh/id_rsa.pub" }
variable "availability_zone" { default = "us-west-2a" }
variable "blueprint_id" { default = "ubuntu_20_04" }
variable "bundle_id" { default = "medium_2_0" }
variable "name" { default = "collectionspace" }
variable "profile" { default = "collectionspace" }

# PROVIDER
provider "aws" {
  profile = var.profile
}

# RESOURCES
resource "aws_lightsail_key_pair" "collectionspace" {
  public_key = file(var.authorized_key)
}

resource "aws_lightsail_instance" "collectionspace" {
  name              = var.name
  availability_zone = var.availability_zone
  blueprint_id      = var.blueprint_id
  bundle_id         = var.bundle_id
  key_pair_name     = aws_lightsail_key_pair.collectionspace.id
  tags              = {
    Name: var.name
  }
}

resource "aws_lightsail_instance_public_ports" "collectionspace" {
  instance_name = aws_lightsail_instance.collectionspace.name

  port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
  }

  port_info {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
  }

  port_info {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
  }
}

resource "aws_lightsail_static_ip" "collectionspace" {
  name = "${var.name}-ip"
}

resource "aws_lightsail_static_ip_attachment" "collectionspace" {
  instance_name  = aws_lightsail_instance.collectionspace.id
  static_ip_name = aws_lightsail_static_ip.collectionspace.id
}

output "ip_address" {
  value = aws_lightsail_static_ip.collectionspace.ip_address
}

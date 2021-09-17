packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "ami_prefix" {
  type    = string
  default = "cspace"
}

// TODO: get this from vars
variable "revision" {
  type    = string
  default = "v7.0-branch"
}

variable "root_volume_size_gb" {
  type    = number
  default = 100
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "ubuntu" {
  profile       = "collectionspace"
  ebs_optimized = true
  instance_type = "t3.large"
  ssh_username  = "ubuntu"
  ssh_timeout   = "2h"

  launch_block_device_mappings {
    device_name           = "/dev/sda1"
    volume_size           = "${var.root_volume_size_gb}"
    volume_type           = "gp3"
    delete_on_termination = true
  }

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }

    most_recent = true
    owners      = ["099720109477"]
  }
}

build {
  name = "collectionspace"

  source "amazon-ebs.ubuntu" {
    name     = "core"
    ami_name = "${var.ami_prefix}-core-${var.revision}-${local.timestamp}"
    tags = {
      tenant = "core"
    }
  }

  source "amazon-ebs.ubuntu" {
    name     = "fcart"
    ami_name = "${var.ami_prefix}-fcart-${var.revision}-${local.timestamp}"
    tags = {
      tenant = "fcart"
    }
  }

  provisioner "ansible" {
    playbook_file = "./security.yml"
    extra_arguments = [
      "--extra-vars", "@vars/build.yml"
    ]
  }

  provisioner "ansible" {
    playbook_file = "./collectionspace.yml"
    extra_arguments = [
      "--extra-vars", "@vars/build.yml",
      "--extra-vars", "collectionspace_tenant=${source.name}",
      "--extra-vars", "{ certbot_certs: [] }"
    ]
  }
}

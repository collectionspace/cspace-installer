# Linode

Linode provides a [thorough tutorial](#) for creating a server using Terraform.

## Quickstart

```bash
cp terraform.tfvars.example terraform.tfvars
```

Update the values in `terraform.tfvars`.

## Variables

### authorized_key

An [SSH public key](#).

### authorized_user

A username for a user that will be created for SSH connections using the authorized key.

### instance_type

The [Linode instance type](#).

### root_pass

Password for the root user.

### token

Your [Linode API token](#).

## Create the server

```bash
terraform init
terraform plan # review changes
terraform apply
terraform output # print public ip address
```

To tear down the server you can use: `terraform destroy`.

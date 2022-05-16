# Linode

Linode provides a [thorough tutorial](#) for creating a server using Terraform.

## Quickstart

```bash
cp terraform.tfvars.example terraform.tfvars
```

Update the values in `terraform.tfvars`.

## Variables

### authorized_key (default: ~/.ssh/id_rsa.pub)

Path to an [SSH public key](#) file added to the root account.

### image (default: linode/ubuntu20.04)

The server operating system image.

### instance_type (default: g6-standard-2)

The [Linode instance type](#).

### root_pass (required)

Password for the root user.

### token (required)

Your [Linode API token](#).

## Create the server

```bash
terraform init
terraform plan # review changes
terraform apply
terraform output # print public ip address
```

To tear down the server you can use: `terraform destroy`.

## Accessing the server

```bash
# format
ssh ${user}@${ip_address}
# example
ssh root@54.43.32.21
```

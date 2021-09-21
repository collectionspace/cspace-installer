# Packer build system

Ensure you have a CollectionSpace AWS profile:

```txt
[collectionspace]
aws_access_key_id = $key
aws_secret_access_key = $secret
```

Or, if using roles:

```txt
[collectionspace]
role_arn = arn:aws:iam::$ACCOUNT_ID:role/OrganizationAccountAccessRole
source_profile = $SOURCE_PROFILE
```

## Setup

Install [Ansible](https://www.ansible.com/) and [Packer](https://www.packer.io/).

```bash
packer init .
packer fmt .
packer validate .
packer build -on-error=ask aws-cspace.pkr.hcl
```

## Launch cspace EC2

**Warning: currently the [certbot role](../requirements.yml) needs to be modified.**

```bash
./scripts/launch fcart fineartmuseum collectionspace.org
```

This will create:

- SSH: `ssh -i ~/.ssh/aws-cspace-pkr ubuntu@fineartmuseum.collectionspace.org`
- Web: https://fineartmuseum.collectionspace.org/cspace/fcart/login

<!-- TODO: cleanup -->
<!-- 1. Delete ec2 instance -->
<!-- 2. Delete / Unregister EIP -->
<!-- 3. Remove DNS entry -->

## Installer reference site

Created using:

```bash
# don't need to run this unless the installer server is not up
./scripts/launch core installer
```

To manange:

```bash
ansible-playbook -i installer.collectionspace.org, collectionspace.yml \
  --user ubuntu \
  --private-key ~/.ssh/aws-cspace-pkr \
  --extra-vars "@vars/build.yml" \
  --extra-vars "collectionspace_tenant=core" \
  --extra-vars "collectionspace_addr=installer.collectionspace.org"
```

To access:

```bash
ssh -i ~/.ssh/aws-cspace-pkr ubuntu@installer.collectionspace.org
```

To view: https://installer.collectionspace.org

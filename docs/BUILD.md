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

Add the site to [containerspace](#) `local.sites.yml` and run terraform to create
the AWS resources. Next:

```bash
./scripts/setup $TENANT $NAME
./scripts/setup fcart museum
```

This will create:

- SSH: `ssh -i ~/.ssh/museum-tb4yb.pem ubuntu@museum.tb4yb.collectionspace.org`
- Web: https://museum.tb4yb.collectionspace.org/cspace/fcart/login

_Note: if didn't create the AWS resources then get the key from containerspace._

When CollectionSpace is running login and create the gateway user:

```txt
Username: gateway@$NAME.tb4yb.collectionspace.org
Password: gateway4u
Roles:    TENANT_READER (checked)
```

On the server restart CollectionSpace: `service collectionspace restart`.

Now add the site to the "TB4YB tracker" list for Outreach. Done!

## Teardown cspace EC2

To delete the resources remove the site entry in `local.sites.yml` and run
terraform to teardown the site.

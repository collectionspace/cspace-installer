## Requirements

On your local machine install:

- Terraform v0.12+ (optional, only if you need to create a server)

On the server you will need (installation instructions provided below):

- Ansible v2.9+
- Ubuntu 18.04 LTS
- Python 3.6+
- SSH enabled and a user with an authorized SSH key

Minimum hardware requirements are:

- 2 cpu
- 4GB RAM
- 50GB disk

## Create infrastructure

**If you already have a server then you can skip this step.**

Follow the instructions for the server provider of your choice:

- [AWS](../cloud/aws/README.md)
- [Digital Ocean](../cloud/digitalocean/README.md)
- [Linode](../cloud/linode/README.md)

These are just a few of the more popular options, but you can use
any server provider so long as the server is reachable via SSH
using an [SSH key](https://www.ssh.com/ssh/key) for authentication.

## Add DNS for server (optional)

We recommend creating an `A record` (or other as preferred) DNS entry
for the server. For example:

- cspace.example.org -> A record -> $PUBLIC_IP_ADDRESS_OF_SERVER

Then access CollectionSpace at:

- http://cspace.example.org # without SSL
- https://cspace.example.org # with SSL

By default the installer will attempt to generate an SSL certificate
using [Lets Encrypt](https://letsencrypt.org/) to protect the publicly
accessible site. If you have not added DNS for the server then you
will need to disable this default behavior (details below).

**SSL is very strongly recommended for a production system.**

## Verify SSH connection

You should be able to SSH to the server using an SSH key for
authentication:

```bash
# assumes current username for user and ~/.ssh/id_rsa for key
ssh $HOSTNAME
# specify username, assumes ~/.ssh/id_rsa for key
ssh $USERNAME@$HOSTNAME
# specify username, key
ssh -i /path/to/key $USERNAME@$HOSTNAME
```

You may receive a `passphrase` prompt if your SSH key has one, but
you should not receive a `password` prompt if key authentication is
being used.

## Choose where to run Ansible

You can run the playbook in two ways:

1. [On the server](SERVER.md)
2. [From your local machine](LOCAL.md)

We generally recommend the first option unless you are already
familiar with Ansible and configuration management tooling.

## Progress summary

It may take one hour or more for the playbook to run to completion
the first time (it depends on many factors, such as allocated server
resources, network performance etc.). Subsequent runs (which can be
done to maintain installer configuration) should be much faster.

It's possible for the installer to get interrupted and fail part way
through the process. Should that happen simply re-run the installer
to determine whether it is able to correct any issues and complete
the deployment. If not then you can reach out with questions on the
[CollectionSpace mailing list](#).

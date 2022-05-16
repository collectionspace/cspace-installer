# Installation

On your local machine install:

- Ansible
- Terraform (optional, only if you need to create a server)

On the server you will need:

- Ubuntu LTS
- SSH enabled

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

You should be able to SSH to the server:

```bash
# assumes current username for user and ~/.ssh/id_rsa for key
ssh $HOSTNAME
# specify username, assumes ~/.ssh/id_rsa for key
ssh $USERNAME@$HOSTNAME
# specify username, key
ssh -i /path/to/key $USERNAME@$HOSTNAME
```

We highly recommend using SSH key authentication and disabling passwords.

## Setup Ansible

Download and [install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installation-guide) on your local machine.
If you're on Windows you can install Ansible using the
[Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about).

Here are the recommended steps for installing Ansible on Ubuntu / WSL:

```bash
# install ansible and other requirements
sudo apt update
sudo apt install --yes git python3 python3-pip software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install --yes ansible
```

**Important:** Add `ServerAliveInterval 120` to your `~/.ssh/config` to prevent
potential SSH timeouts during build steps. A minimal SSH config would look like:

```txt
Host *
ServerAliveInterval 120
```

Download the playbook to your local machine:

```bash
# download and setup ansible playbook
git clone https://github.com/collectionspace/cspace-installer.git
cd cspace-installer
ansible-galaxy install -r requirements.yml --force
```

Before proceeding check for any [role gotchas](../README.md#role-gotchas)
(workarounds that are required pending review of a more permanent
solution).

## Running Ansible

For Ansible to setup CollectionSpace on your server you will need to
create a variables file:

```bash
cp vars/example.yml vars/deploy.yml
```

Update the config following the instructions in file. Be sure to create
a secure backup of this file as you'll need it every time the playbook
is run.

```bash
DOMAIN=installer.collectionspace.org
USER=root

# only run this if you want to apply security configuration / updates
ansible-playbook -i $DOMAIN, security.yml -u $USER -e @vars/deploy.yml

# install collectionspace and dependencies
ansible-playbook -i $DOMAIN, collectionspace.yml -u $USER -e @vars/deploy.yml
```

By default ansible will attempt to use ~/.ssh/id_rsa for SSH key auth
but you can override this on the command line:

```bash
ansible-playbook -i $DOMAIN, collectionspace.yml \
  -u $USER \
  -e @vars/deploy.yml \
  --private-key ~/.ssh/my_private_key
```

## Progress summary

It may take one hour or more for the playbook to run to completion
the first time (it depends on many factors, such as allocated server
resources, network performance etc.). Subsequent runs (which can be
done to maintain installer configuration) should be much faster.

It's possible for the installer to get interrupted and fail part way
through the process. Should that happen simply re-run the installer
to determine whether it is able to correct any issues and complete
the deployment. If not then you can reach out with questions on the
[CollectionSpace mailing list](http://lists.collectionspace.org/mailman/listinfo/talk_lists.collectionspace.org).


## Next steps

Review the [system overview](SYSTEM.md) documentation.

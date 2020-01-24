## Setup

If you don't have a server to use currently there are
[Terraform](https://www.terraform.io/) configurations for creating a
server on these platforms:

- [AWS](https://aws.amazon.com/) using [Lightsail](https://aws.amazon.com/lightsail/)
- [Digital Ocean](https://www.digitalocean.com/)
- [Linode](https://www.linode.com/)

The installer is tested on Mac OS and Ubuntu Linux. If you're on Windows
you can run the installer using [WSL](https://docs.microsoft.com/en-us/windows/wsl/about)
(Windows Subsystem for Linux).

## Requirements

On your local machine install:

- Ansible v2.9+
- Python 3.6+ (required by Ansible, probably already installed)
- Terraform v0.12+ (optional, only if you need to create a server)

*If you're on Windows install the requirements using the WSL shell.*

On a self hosted / managed server you will need:

- Ubuntu 18.04 LTS
- Python 3.6+
- SSH enabled and a user with an authorized SSH key

Servers created by Terraform will have these requirements
pre-installed.

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

Then you will access ColletionSpace at: https://cspace.example.org

The installer uses [Lets Encrypt](https://letsencrypt.org/) to generate
an SSL certificate to protect the publicly accessible site. For testing
this can be disabled by setting the Ansible environment to `test` (more
details below). You can then access CollectionSpace by domain or IP address
without SSL.

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

## Download playbook and setup Ansible

Begin by [downloading the playbook](#) and unzipping it, or cloning it if
using [git](https://git-scm.com/).

From the playbook directory pull the Ansible roles (libraries):

```bash
cd /path/to/cspace-installer
ansible-galaxy install -r requirements.yml --force
```

For Ansible to setup CollectionSpace on your server you will need to
create a variables file:

```bash
cp vars/example.yml vars/deploy.yml
```

Update the config following the instructions in file. Be sure to create
a secure backup of this file as you'll need it every time the playbook
is run.

## Running Ansible

Running the playbook requires a user with `sudo` privileges:

```bash
# by default the ssh user is the current user, and the ssh key is ~/.ssh/id_rsa
ansible-playbook -i $HOSTNAME, playbook.yml -e @vars/deploy.yml

# the user / key can be specified on the command line
ansible-playbook -i $HOSTNAME, playbook.yml \
  --user=admin \
  --private-key=~/.ssh/admin \
  --extra-vars=@vars/deploy.yml
```

**Important: the "," after $HOSTNAME is required!**

See the [ansible-playbook](https://docs.ansible.com/ansible/latest/cli/ansible-playbook.html)
docs for all of the CLI connection options.

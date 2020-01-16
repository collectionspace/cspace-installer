# CollectionSpace Installer

**Work in progress: targeting v5.3 (03/2020) for v1.0 release**

The installer provides an [Ansible](#) playbook for setting up
[CollectionSpace](#) on a remote [Ubuntu](#) server. All of the
components in a CollectionSpace system will be installed onto the
target machine:

- CollectionSpace application
- CollectionSpace public gateway
- [ElasticSearch](#)
- [Nginx](#) web proxy
- [Postgres](#) database server

All of the standard CollectionSpace tenants can be enabled via
configuration and by using one (or more) of the provided tenants
your CollectionSpace system will be on the recommended and supported
upgrade path.

Some minimal system configuration updates are applied, including:

- Firewall is enabled (default deny policy) with execeptions for HTTP & SSH
- Software packages are updated automatically
- SSH ip addresses can be whitelisted (default: all)
- SSH password authentication is disabled

These are baseline security features that are required to facilitate
installer development. Otherwise the installer attempts to be as
unopinionated as possible on the target machine so your preferences for
tools like backups, monitoring, user management etc. can be decided and
applied separately.

If you don't have a server to use currently there are [Terraform](#)
configurations for creating a server on these platforms:

- [AWS](#) using [Lightsail](#)
- [Digital Ocean](#)
- [Linode](#)
- [Microsoft Azure](#)

The installer is tested on Mac OS and Ubuntu Linux. If you're on Windows
you can run the installer using [WSL](#) (Windows Subsystem for Linux).

## Requirements

On your local machine install:

- Ansible v2.9+
- Git (optional, if you want to version control your configuration)
- Python 3.6+ (required by Ansible, probably already installed)
- Terraform v0.12+ (optional, only if you need to create a server)

*If you're on Windows install the requirements using the WSL shell.*

With Ansible installed download this repository, but if you are
comfortable with Git you may prefer to fork and clone it instead.

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

## Steps

### Create infrastructure

**If you already have a server then you can skip this step.**

Follow the instructions for the server provider of your choice:

- [AWS](#)
- [Digital Ocean](#)
- [Linode](cloud/linode/README.md)
- [Microsoft Azure](#)

These are just a few of the more popular options, but you can use
any server provider so long as the server is reachable via SSH
using an [SSH key](#) for authentication.

### Add DNS for server (optional)

We recommend creating an `A record` (or other as preferred) DNS entry
for the server. For example:

- cspace.example.org -> A record -> $PUBLIC_IP_ADDRESS_OF_SERVER

Then you will access ColletionSpace at: https://cspace.example.org

The installer uses [Lets Encrypt](#) to generate an SSL certificate
to protect the publicly accessible site. For testing this can be
disabled by setting the Ansible environment to `test` (more details
below). You can then access CollectionSpace by domain or IP address
without SSL.

### Verify SSH connection

You should be able to SSH to the server using an SSH key for
authentication:

```bash
# assumes current username for user and ~/.ssh/id_rsa for key
ssh $hostname
# specify username, assumes ~/.ssh/id_rsa for key
ssh $username@$hostname
# specify username, key
ssh -i /path/to/key $username@$hostname
```

You may receive a `passphrase` prompt if your SSH key has one, but
you should not receive a `password` prompt if key authentication is
being used.

### Setup Ansible

Start by downloading the Ansible roles (libraries):

```bash
cd /path/to/cspace-installer
ansible-galaxy ...
```

For Ansible to setup CollectionSpace on your server you will need to
create an inventory file:

```bash
ENVIRONMENT=production # or 'staging', 'test' etc.
mkdir inventory/$ENVIRONMENT
cp inventory/example/hosts inventory/$ENVIRONMENT/
```

Update the config following the instructions in file.

Running the playbook requires a user with `sudo` privileges:

```bash
# by default the ssh user is the current user, and the ssh key is ~/.ssh/id_rsa
ansible-playbook -i inventory/$ENVIRONMENT/hosts playbook.yml

# the user / key can be specified on the command line
ansible-playbook -i inventory/$ENVIRONMENT/hosts playbook.yml \
  --user=admin \
  --private-key=~/.ssh/admin
```

See the [ansible-playbook](https://docs.ansible.com/ansible/latest/cli/ansible-playbook.html)
docs for all of the CLI connection options.

## License

This project is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

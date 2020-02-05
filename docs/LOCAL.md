## Running Ansible (locally)

Download and [install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installation-guide) on your local machine.

You do not have to SSH to the server when running Ansible locally.

Add `ServerAliveInterval 120` to your `~/.ssh/config` to prevent
potential SSH timeouts during build steps. If you're on Windows
you can install Ansible using the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about).

Download the playbook to your local machine.

```bash
# download and setup ansible playbook
git clone https://github.com/collectionspace/cspace-installer.git
cd cspace-installer
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

```bash
DOMAIN=installer.collectionspace.org
USER=root
ansible-playbook -i $DOMAIN, playbook.yml -u $USER -e @vars/deploy.yml
```

See the [documentation](https://docs.ansible.com/ansible/latest/cli/ansible-playbook.html)
for the common CLI options.

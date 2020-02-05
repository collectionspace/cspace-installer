## Download playbook and setup Ansible (on the server)

Begin by SSHing to the server.

```bash
# install ansible and other requirements
sudo apt update
sudo apt install --yes git python3 python3-pip software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install --yes ansible

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

## Running Ansible (on the server)

Running the playbook requires a user with `sudo` privileges:

```bash
ansible-playbook --connection=local -i localhost, playbook.yml -e @vars/deploy.yml
```

You can use `tags` to limit the range of tasks that are run:

```bash
ansible-playbook --connection=local -i localhost, playbook.yml --list-tags

# run only the collectionspace role tasks
ansible-playbook --connection=local -i localhost, playbook.yml \
  -e @vars/deploy.yml \
  --tags=collectionspace
```

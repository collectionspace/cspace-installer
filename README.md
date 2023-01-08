# CollectionSpace Installer

![](https://github.com/collectionspace/cspace-installer/workflows/Lint%20Installer/badge.svg)

The installer provides an [Ansible](https://www.ansible.com/) playbook
for setting up [CollectionSpace](https://www.collectionspace.org/) on an
[Ubuntu](https://ubuntu.com/) server consistent with the [official
documentation](https://collectionspace.atlassian.net/wiki/spaces/DOC/pages/701465498/Installing+on+Ubuntu+LTS).

For a turn-key, production ready deployment there are just two requirements:

- An Ubuntu server reachable via SSH
- DNS configured to access the server by hostname

All of the components in a CollectionSpace system will be installed:

- CollectionSpace application
- CollectionSpace public gateway & browser
- [ElasticSearch](https://www.elastic.co/)
- [Nginx](https://www.nginx.com/) web proxy
- [Postgres](https://www.postgresql.org/) database server

Some minimal system configuration updates can be applied, including:

- Enable firewall (default deny policy) with exceptions for HTTP & SSH
- Software packages are updated automatically
- SSH ip addresses can be whitelisted
- SSH password authentication is disabled
- SSH for root user login can be disabled

These features are optional but highly recommended. If you do not use
these features of the installer we strongly advise hardening and
securing your server before running the installer.

We recommend starting with a newly created server as a buildup to a
production deployment. As you become familiar with the installation
process and CollectionSpace you may want to wipe and reload the
Operating System a few times before settling on a final configuration
/ setup.

See the [documentation](docs/README.md) for full instructions.

## Role gotchas

Elasticsearch role update line#95 in `./roles/elasticsearch/templates/jvm.options.j2`:

```
-Djava.io.tmpdir=/tmp # replaces: -Djava.io.tmpdir={ES_TMPDIR}
```

## Developer Quickstart

Add `ServerAliveInterval 120` to your `~/.ssh/config` then create `vars/deploy.yml`:

```yml
---
certbot_admin_email: no-reply@collectionspace.org
certbot_certs: [] # comment this out if you've added dns and want an SSL cert to be created
collectionspace_csadmin_password: keepmesecretplz
collectionspace_force_build: False
# update this (IP or domain): for vagrant use: "localhost" [wsl], or "collectionspace.local" [native]
collectionspace_addr: 45.33.112.113
collectionspace_tenant: core
permit_dev_ports: false
permit_root_login: 'no'
# or, to allow all: - 0.0.0.0/0
ssh_allowed_ip_addresses:
  - "{{ lookup('url', 'http://checkip.amazonaws.com', split_lines=False) | replace('\n', '') }}"
users:
  - name: deploy
    shell: bin/bash
    public_key: "{{ lookup('file', lookup('env','HOME') + '/.ssh/id_rsa.pub') }}"
```

### Run it locally

Install:

- [Ansible](https://www.ansible.com/)
- [Docker](https://www.docker.com/)
- [Vagrant](https://www.vagrantup.com/)

Then:

```bash
ansible-galaxy install -r requirements.yml --force # update if any gotchas

# Linux/Ubuntu
sudo apt-get install sshpass
# Mac/OSX
brew install hudochenkov/sshpass/sshpass

vagrant plugin install vagrant-hostmanager
vagrant up

# when the provisioning has completed we have to kick it
# because we have no service manager in a vagrant / docker env
vagrant ssh # password 'root'
su - collectionspace
$CSPACE_JEESERVER_HOME/bin/startup.sh
# to view logs
tail -f $CSPACE_JEESERVER_HOME/logs/catalina.out
```

Running locally does not run the security tasks.

### Run it using an existing server

```bash
DOMAIN_OR_IP=45.33.112.113
ansible-playbook -i $DOMAIN_OR_IP, security.yml -u root -e @vars/deploy.yml # -u ubuntu (for lightsail)
ansible-playbook -i $DOMAIN_OR_IP, collectionspace.yml -u deploy -e @vars/deploy.yml
```

### Access CollectionSpace

Either way CollectionSpace will be available at: http://{collectionspace_addr}

## License

This project is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

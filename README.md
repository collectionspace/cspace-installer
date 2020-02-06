# CollectionSpace Installer

**Work in progress: targeting v5.3 (03/2020) for v1.0 release**

The installer provides an [Ansible](https://www.ansible.com/) playbook
for setting up [CollectionSpace](https://www.collectionspace.org/) on an
[Ubuntu](https://ubuntu.com/) server consistent with the [official
documentation](https://collectionspace.atlassian.net/wiki/spaces/DOC/pages/701465498/Installing+on+Ubuntu+LTS).

For a turn-key, production ready deployment there are just two requirements:

- An Ubuntu server reachable via SSH
- DNS configured to access the server by hostname

All of the components in a CollectionSpace system will be installed:

- CollectionSpace application
- CollectionSpace public gateway
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

We recommend starting with a newly created server and a freshly
installed OS as a buildup to a production deployment. As you become
familiar with the installation process and CollectionSpace you may want
to wipe and reload the Operating System a few times before settling on
a final configuration / setup.

See the [documentation](docs/README.md) for full instructions.

## Developer Quickstart

Create server with root key access, then:

```bash
cp vars/example.yml vars/deploy.yml # update values as needed
DOMAIN=installer.collectionspace.org
ansible-playbook -i $DOMAIN, security.yml -u root -e @vars/deploy.yml
ansible-playbook -i $DOMAIN, collectionspace.yml -u deploy -e @vars/deploy.yml
```

## License

This project is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

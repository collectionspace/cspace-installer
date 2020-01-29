# CollectionSpace Installer

**Work in progress: targeting v5.3 (03/2020) for v1.0 release**

The installer provides an [Ansible](https://www.ansible.com/) playbook
for setting up [CollectionSpace](https://www.collectionspace.org/) on a
remote [Ubuntu](https://ubuntu.com/) server consistent with the [official
documentation](https://collectionspace.atlassian.net/wiki/spaces/DOC/pages/701465498/Installing+on+Ubuntu+LTS).

All of the components in a CollectionSpace system will be installed onto
the target machine:

- CollectionSpace application
- CollectionSpace public gateway
- [ElasticSearch](https://www.elastic.co/)
- [Nginx](https://www.nginx.com/) web proxy
- [Postgres](https://www.postgresql.org/) database server

All of the standard CollectionSpace tenants can be enabled via a
single configuration file and by using one (or more) of the provided
tenants your CollectionSpace system will be on the recommended and
supported upgrade path.

Some minimal system configuration updates are applied, including:

- Firewall is enabled (default deny policy) with exceptions for HTTP & SSH
- Software packages are updated automatically
- SSH ip addresses can be whitelisted (default: current location IP address)
- SSH password authentication is disabled
- SSH for root user login can be disabled (default: disabled)
- Standard user accounts can be created (default: 'deploy')

These are baseline security features that are required to facilitate
installer development. Otherwise the installer attempts to be as
unopinionated as possible on the target machine so your preferences for
tools like backups, monitoring, user management etc. can be decided and
applied separately.

We strongly advise starting with a newly created server and a freshly
installed OS as a buildup to a production deployment. As you become
familiar with the installation process and CollectionSpace you may want
to wipe and reload the Operating System a few times before settling on
a final configuration / setup.

See the [documentation](docs/README.md) for full instructions.

## License

This project is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

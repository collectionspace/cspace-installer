# Ansible Role: CollectionSpace

An Ansible Role that installs CollectionSpace on Ubuntu.

## Role Variables

Available variables are listed below, along with the [default values](defaults/main.yml):

    collectionspace_allocated_ram: '1524m'

The amount of memory allocated to CollectionSpace (can use gigabytes i.e. "2g").

    collectionspace_csadmin_password: False

The password for the csadmin database user.

    collectionspace_environment: # ...

The CollectionSpace environment variables. See [defaults](defaults/main.yml).

    collectionspace_force_build: False

Run build steps regardless of conditional task status.

    collectionspace_revision: 'v6.1.1'

The CollectionSpace source branch / tag / commit to build.

    collectionspace_tenant: 'core'

The list of tenants that will be enabled **and** accessible via the web interface.

    collectionspace_tomcat_version: 'apache-tomcat-8.5.40'

The Tomcat package version.

    collectionspace_version: '6.0'

The version to use when installing CollectionSpace.

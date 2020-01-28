# Ansible Role: CollectionSpace

An Ansible Role that installs CollectionSpace on Ubuntu.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    collectionspace_allocated_ram: "1524m"

The amount of memory allocated to CollectionSpace (can use gigabytes i.e. "2g").

    collectionspace_csadmin_password: False

The password for the csadmin database user.

    collectionspace_environment: # ...

The CollectionSpace environment variables. See `defaults`.

    collectionspace_tenants:
        - name: core

The list of tenants that will be enabled.

    collectionspace_tomcat_version: 'apache-tomcat-8.5.40'

The Tomcat package version.

    collectionspace_version: '5.2'

The version to use when installing CollectionSpace.

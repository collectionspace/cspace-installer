# Ansible Role: CollectionSpace

An Ansible Role that installs CollectionSpace on Ubuntu.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    collectionspace_allocated_ram: "1524m"

The amount of memory allocated to CollectionSpace (can use gigabytes i.e. "2g").

    collectionspace_csadmin_password: False

The password for the csadmin database user.

    collectionspace_version: '5.2'

The version to use when installing CollectionSpace.

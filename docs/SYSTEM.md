## System overview

The CollectionSpace application will be available at:

- http://cspace.example.org # without SSL
- https://cspace.example.org # with SSL

Replace `cspace.example.org` with your domain or IP address.

Initial login credentials are:

- username: admin@$TENANT.collectionspace.org
- password: Administrator

Where `$TENANT` is the value of the `collectionspace_tenant` variable
(i.e. admin@core.collectionspace.org).

**For custom tenants the username is set in the tenants settings.xml.**

## Installer managed components

Names, locations and notes for the CollectionSpace components:

### CollectionSpace

Role: CollectionSpace application server.

- Location: /opt/collectionspace/server/
- Logs: /opt/collectionspace/server/logs/catalina.out
- Port: 8180

### Gateway

Role: Facilitates access to published data.

- TODO

### ElasticSearch

Role: Search index for public browser applications.

- Location: /var/lib/elasticsearch/
- Logs: /var/log/elasticsearch/
- Port: 9200

### Nginx

Role: Handles requests from the internet, proxied to the app server.

- Location: /etc/nginx/
- Logs: /var/log/nginx/
- Port: 80,443 # latter if SSL enabled
- Site config: /etc/nginx/sites-enabled/cspace.conf

### Postgres

Role: Data store.

- Location: /var/lib/postgresql/
- Logs: /var/log/postgresql/
- Port: 5432

#### Connecting to Postgres

```bash
# connect to the auth db
psql -h localhost -U csadmin -d cspace_core
# connect to the content db for the core tenant
psql -h localhost -U csadmin -d nuxeo_default
# connect to the content db for any other tenant
TENANT=fcart
psql -h localhost -U csadmin -d ${TENANT}_default
```

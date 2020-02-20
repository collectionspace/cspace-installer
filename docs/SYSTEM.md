## System overview

The CollectionSpace application will be available at:

- http://cspace.example.org # without SSL
- https://cspace.example.org # with SSL

Replace `cspace.example.org` with your domain or IP address.

Initial login credentials are:

- username: admin@$domain (i.e. admin@cspace.example.org)
- password: Administrator

Installer managed components:

__CollectionSpace__

- Location: /opt/collectionspace/server/
- Logs: /opt/collectionspace/server/logs/catalina.out
- Port: 8180

__Gateway__

TODO.

__ElasticSearch__

- Location: /var/lib/elasticsearch/
- Logs: /var/log/elasticsearch/
- Port: 9200

__Nginx__

- Location: /etc/nginx/
- Logs: /var/log/nginx/
- Port: 80,443 # latter if SSL enabled

__Postgres__

- Location: /var/lib/postgresql/
- Logs: /var/log/postgresql/
- Port: 5432

```bash
# connect to the auth db
psql -h localhost -U csadmin -d cspace_core
# connect to the content db for the core tenant
psql -h localhost -U csadmin -d nuxeo_default
# connect to the content db for any other tenant
TENANT=fcart
psql -h localhost -U csadmin -d ${TENANT}_default
```

# Building CollectionSpace docker images

Requires:

- Docker
- Docker compose

```
# build the db
cd db
docker build -t collectionspace:db .

# build & run cspace
cd ../cs/
docker-compose build
docker-compose up -d db
docker-compose up -d es
docker-compose run --rm app /create_db.sh
docker-compose up
```

Wait for the "Server startup" message then access CollectionSpace at: http://localhost:8180

- username: admin@core.collectionspace.org
- password: Administator

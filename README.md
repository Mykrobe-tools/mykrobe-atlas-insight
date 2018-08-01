# mykrobe-atlas-insight

Dockerised kafka solution to stream the data from mongodb to mysql.

# Installation

To create the insight containers run the following command in the server.

```
docker-compose build
```

```
docker-compose up -d
```

Once the database container is created, run the sql script inside sql folder to create the mysql tables.

# Install the connector

Make the following api rest call to create the connector:

```
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://kafka.makeandship.com:8083/connectors/ -d @connectors/mongo-source.json
```

# Start the mysql consumer

## Configuration

see [ms-kafka](https://bitbucket.org/makeandship/ms-kafka/src/master/) repository

Change docker-compose-consumer.yml by adding you settings:

```
consumer:
  build: ./consumer/
  container_name: consumer
  external_links:
    - zookeeper
    - kafka
  environment:
    - TOPIC=<YOUR_TOPIC_NAME>
    - GROUP_ID=<YOUR_GROUP_ID>
    - MYSQL_HOST=<YOUR_DATABASE_HOST>
    - MYSQL_USER=<YOUR_DATABASE_USER>
    - MYSQL_PASSWORD=<YOUR_DATABASE_PASSWORD>
    - MYSQL_DATABASE=<YOUR_DATABASE_NAME>
    - MYSQL_PORT=<YOUR_DATABASE_PORT>
    - MYSQL_TABLE_NAME=<YOUR_TABLE_NAME>
    - BLACKLIST_FIELDS=<YOUR_BLACKLIST_FIELDS>
```

## Installation

After the configuration run the following command in the kafka server

```
docker-compose -f docker-compose-consumer.yml up -d
```
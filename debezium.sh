curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d '{
    "name": "mysql-connector",
    "config": {
      "connector.class": "io.debezium.connector.mysql.MySqlConnector",
      "tasks.max": "1",
      "database.hostname": "localhost",
      "database.port": "3306",
      "database.user": "root",
      "database.password": "secret",
      "database.server.id": "12345",
      "database.server.name": "dbserver1",
      "database.include.list": "local_test",
      "topic.prefix": "mysql",
      "include.schema.changes": "true",
      "schema.history.internal.kafka.bootstrap.servers": "localhost:9092",
      "schema.history.internal.kafka.topic": "schema-changes.test"
    }
  }'



curl -X PUT http://localhost:8083/connectors/mysql-connector/config \
  -H "Content-Type: application/json" \
  -d '{
    "name": "mysql-connector",
    "config": {
      "connector.class": "io.debezium.connector.mysql.MySqlConnector",
      "tasks.max": "1",
      "database.hostname": "localhost",
      "database.port": "3306",
      "database.user": "root",
      "database.password": "secret",
      "database.server.id": "12345",
      "database.server.name": "dbserver1",
      "database.include.list": "orders",
      "topic.prefix": "mysql",
      "include.schema.changes": "true",
      "schema.history.internal.kafka.bootstrap.servers": "localhost:9092",
      "schema.history.internal.kafka.topic": "schema-changes.orders"
    }
  }'
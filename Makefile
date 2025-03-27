.PHONY: run-mysql

run-mysql:
	docker-compose -f compose/db.yaml up -d mysql


.PHONY: run-kafka

run-kafka:
	docker-compose -f compose/kafka.yaml --project-name kafka up -d


run-mysql-cdc:
	docker-compose -f compose/cdc.yaml up -d mysql-connector

run-debezium-ui:
	docker-compose -f compose/cdc.yaml up -d debezium-ui
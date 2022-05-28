postgres:
	 docker run --name postgres14c -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=root -d postgres:14-alpine
createdb:
	docker exec -it postgres14c createdb -U postgres --username=postgres --owner=postgres bank

dropdb:
	docker exec -it postgres14c dropdb -U postgres bank
migrateup:
	migrate -path db/migration -database "postgresql://postgres:root@localhost:5432/bank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://postgres:root@localhost:5432/bank?sslmode=disable" -verbose down
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
.PHONY:	postgres createdb dropdb migrateup migratedown sqlc test

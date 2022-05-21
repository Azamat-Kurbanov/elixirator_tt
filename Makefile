build:
	docker compose build

start:
	docker compose up -d

stop:
	docker compose stop

restart:
	make stop
	make start

rebuild:
	make build
	make start

down:
	docker compose down

deps.get:
	docker compose run --rm phoenix mix deps.get

compile:
	docker compose run --rm phoenix mix compile

run.tests:
	docker compose run --rm phoenix mix test

mix:
	docker compose run --rm phoenix mix $(command)

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
	docker compose build
	make start

down:
	docker compose down

mix:
	docker compose run --rm phoenix mix $(command)

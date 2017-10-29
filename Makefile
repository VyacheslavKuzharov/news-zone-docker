#!make

EXEC = docker-compose exec
RUN = docker-compose run
START = docker-compose up -d
STOP = docker-compose stop
LOGS = docker-compose logs


.PHONY: up stop restart status hosts rebuild help

up:
	@echo "\n\033[0;33m Spinning up docker environment... \033[0m"
	@$(START)
	@$(MAKE) status

stop:
	@echo "\n\033[0;33m Halting containers... \033[0m"
	@docker-compose stop
	@$(MAKE) status

restart:
	@echo "\n\033[0;33m Restarting containers... \033[0m"
	@docker-compose stop
	@$(START)
	@$(MAKE) status

status:
	@echo "\n\033[0;33m Containers statuses \033[0m"
	@docker-compose ps

hosts:
	@echo "\n\033[1;m Adding record in to your local /etc/hosts file.\033[0m"
	@echo "\n\033[1;m Please use your local sudo password.\033[0m"
	@echo '127.0.0.1 localhost dev.newszone.com'| sudo tee -a /etc/hosts
	@echo "\n\033[1;m Your app available at http://dev.newszone.com/ \033[0m"

rebuild: stop
	@echo "\n\033[0;33m Rebuilding containers... \033[0m"
	@docker-compose build --no-cache

migrate: stop
	@echo "\n\033[0;33m rails db:migrate... \033[0m"
	@docker-compose run backend rails db:migrate
	@$(START)
	@$(MAKE) status

logs-backend:
	@$(LOGS) --tail=100 -f backend


help:
	@echo "\033[1;32mdocker-env\t\t- Main scenario, used by default\033[0m"

	@echo "\n\033[1mMain section\033[0m"
	@echo "rebuild\t\t\t- build containers w/o cache"
	@echo "up\t\t\t- start project"
	@echo "stop\t\t\t- stop project"
	@echo "status\t\t\t- show status of containers"
	@echo "hosts\t\t\t- add record set in /etc/hosts file"


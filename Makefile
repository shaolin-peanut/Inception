HOSTSFILE	=	/etc/hosts
HOSTALIAS	=	127.0.0.1 $(DOMAIN_NAME)

ps:
	@docker ps

up:
	sudo mkdir -p /Users/$(MYSQL_USER)/data/wordpress
	sudo mkdir -p /Users/$(MYSQL_USER)/data/mariadb
	docker compose -f srcs/docker-compose.yml up --detach --build

down:
	docker compose -f srcs/docker-compose.yml down

clean-image:
	docker image rm mariadb
	docker image rm wordpress
	docker image rm nginx

clean-volume:
	docker volume rm db
	docker volume rm wp

fclean:
	docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null

re: down up

hostname:
	grep "$(HOSTALIAS)" "$(HOSTSFILE)" || echo "$(HOSTALIAS)" >> "$(HOSTSFILE)"

base:
	@make -C $(DBASE)
	@docker run --rm $(NBASE)
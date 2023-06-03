all:
	sudo mkdir -p $(HOME)/data/wordpress
	sudo mkdir -p $(HOME)/data/mariadb
	make up

up:
	docker compose -f srcs/docker-compose.yml up --detach --build

down:
	docker compose -f srcs/docker-compose.yml down

fclean:
	sudo rm -rf $(HOME)/data/wordpress/*
	sudo rm -rf $(HOME)/data/mariadb/*
	docker stop `docker ps -qa`; docker rm `docker ps -qa`; docker rmi -f `docker images -qa`; docker volume rm `docker volume ls -q`; docker network rm `docker network ls -q` 2>/dev/null
	docker system prune -f
  
re: fclean all

NAME        := inception
VOLUMES     := ./data
COMPOSE     := srcs/docker-compose.yml

MAKEFLAGS   += --no-print-directory

all: setup build up

# sets up necessary environment
setup:
	- touch 1
	-if ! grep -q "$(NAME).fr" /etc/hosts; then echo "127.0.0.1 $(NAME).fr" | sudo tee -a /etc/hosts; fi
	-mkdir -p $(VOLUMES)/wordpress
	-mkdir -p $(VOLUMES)/mariadb
	echo "[make] setup ok"
	- touch 2

# build or update images
build:
	- touch 3
	-docker compose --file $(COMPOSE) build && echo "[make] build ok"
	- touch 4

# start and enable services
up:
	- touch 5
	-docker compose --file $(COMPOSE) up --detach && echo "[make] up ok"
	- touch 6

# pause services
stop:
	-docker compose --file $(COMPOSE) stop && echo "[make] stop ok"

# shutdown and remove services
down:
	-docker compose --file $(COMPOSE) down && echo "[make] down ok"

# remove docker containers, networks and volumes
clean:
	-docker compose --file $(COMPOSE) down --volumes --remove-orphans && echo "[make] clean ok"

# remove all generated files and modifications !!! like volumes data !!!
fclean:
	$(MAKE) clean
	-sudo rm -rf $(VOLUMES)
	-sudo sed -i '/$(NAME)/d' /etc/hosts
	echo "[make] fclean ok"

# rebuild app from scratch
re:
	$(MAKE) clean
	$(MAKE) all
	echo "[make] re ok"

.PHONY: setup build up stop down clean fclean re
.SILENT:

UNAME = $(shell uname -s)
USERNAME = yuhayrap
COMPOSE_PATH = ./srcs/docker-compose.yml

green := \033[32m
yellow := \033[33m
reset := \033[0m
red := \033[31m

ifeq ($(UNAME), Darwin)
	DOCKER_COMPOSE =  docker-compose
else
	DOCKER_COMPOSE = docker compose
endif

all: up

build:
	@echo "$(yellow)===============================$(reset)"
	@echo "$(yellow)======= Building images =======$(reset)"
	@echo "$(yellow)===============================$(reset)"
	@${DOCKER_COMPOSE} -f ${COMPOSE_PATH} build
	@echo "$(yellow)=========================================$(reset)"
	@echo "$(yellow)======= Images build successfully =======$(reset)"
	@echo "$(yellow)=========================================$(reset)"

up: configure_volumes build
	@echo "$(green)==================================$(reset)"
	@echo "$(green)======= Lifting containers =======$(reset)"
	@echo "$(green)==================================$(reset)"
	@${DOCKER_COMPOSE} -f ${COMPOSE_PATH} up

up_background: configure_volumes build
	@echo "$(green)==================================$(reset)"
	@echo "$(green)======= Lifting containers =======$(reset)"
	@echo "$(green)==================================$(reset)"
	@${DOCKER_COMPOSE} -f ${COMPOSE_PATH} up  --build -d
	@echo "$(green)================================$(reset)"
	@echo "$(green)======= Containers ready =======$(reset)"
	@echo "$(green)================================$(reset)"

down:
	@echo "$(red)===================================$(reset)"
	@echo "$(red)======= Dropping containers =======$(reset)"
	@echo "$(red)===================================$(reset)"
	@${DOCKER_COMPOSE} -f ${COMPOSE_PATH} down
	@echo "$(red)===============================================$(reset)"
	@echo "$(red)======= Containers dropped successfully =======$(reset)"
	@echo "$(red)===============================================$(reset)"


hard_down:
	@echo "$(red)===============================================$(reset)"
	@echo "$(red)======= Dropping containers and volumes =======$(reset)"
	@echo "$(red)===============================================$(reset)"
	@${DOCKER_COMPOSE} -f ${COMPOSE_PATH} down -v
	@echo "$(red)===========================================================$(reset)"
	@echo "$(red)======= Containers and volumes dropped successfully =======$(reset)"
	@echo "$(red)===========================================================$(reset)"

start:
	@echo "$(green)===================================$(reset)"
	@echo "$(green)======= Starting containers =======$(reset)"
	@echo "$(green)===================================$(reset)"
	@${DOCKER_COMPOSE} -f ${COMPOSE_PATH} start
	@echo "$(green)==================================$(reset)"
	@echo "$(green)======= Containers started =======$(reset)"
	@echo "$(green)==================================$(reset)"


stop:
	@echo "$(red)===================================$(reset)"
	@echo "$(red)======= Stopping containers =======$(reset)"
	@echo "$(red)===================================$(reset)"
	@${DOCKER_COMPOSE} -f ${COMPOSE_PATH} stop
	@echo "$(red)==================================$(reset)"
	@echo "$(red)======= Containers stopped =======$(reset)"
	@echo "$(red)==================================$(reset)"

configure_volumes:
	@echo "$(green)Creating directories for volumes$(reset)"
	@mkdir -p /home/$(USERNAME)/data
	@mkdir -p /home/$(USERNAME)/data/mariadb
	@mkdir -p /home/$(USERNAME)/data/wordpress
	@echo "$(green)Directories created successfully$(reset)"

remove_volumes:
	@echo "$(red)Deleting directories for volumes$(reset)"
	@rm -rf home/$(USERNAME)/data/mariadb
	@rm -rf /home/$(USERNAME)/data/wordpress
	@rm -rf /home/$(USERNAME)/data
	@echo "$(red)Directories deleted successfully$(reset)"

remove_all: hard_down remove_volumes
	@docker system prune -a
	@if [ -n "$(shell docker images -q)" ]; then \
    		docker rmi -f $(shell docker images -q); \
    	else \
    		echo "No images to delete."; \
	fi

re: remove_all up

info:
	docker system df

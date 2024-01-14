SERVICE_NAME=hello-world-printer
DOCKER_IMG_NAME=$(SERVICE_NAME)
USERNAME=beatazalewa
TAG=$(USERNAME)/$(DOCKER_IMG_NAME)

.PHONY: deps test
.DEFAULT_GOAL := test

dep:
	pip install -r requirements.txt; \
		pip install -r test_requirements.txt

run:
	python main.py

test:
	PYTHONPATH=. py.test

test_verbose:
	PYTHONPATH=. py.test --verbose -s

lint:
	flake8 hello_world test

docker_build:
	docker build -t $(DOCKER_IMG_NAME) .

docker_run: docker_build
	docker run \
		 --name $(DOCKER_IMG_NAME)-dev \
		 -p 5000:5000 \
		 -d $(DOCKER_IMG_NAME)

docker_start:
	docker start $(DOCKER_IMG_NAME)-dev
	docker ps

docker_stop:
	docker stop $(DOCKER_IMG_NAME)-dev
	docker ps -a

docker_push: docker_build
	@docker login --username $(USERNAME) --password
	$${DOCKER_PASSWORD}; \
	docker tag $(DOCKER_IMG_NAME) $(TAG); \
	docker push $(TAG); \
	docker logout;

docker_remove:
	docker rm $(SERVICE_NAME)-dev

docker_commit:
	docker commit $(SERVICE_NAME)-dev $(USERNAME)/$(REPO):$(TAG)




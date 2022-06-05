.PHONY: deps test

deps:
	pip install -r requirements.txt; \
		pip install -r test_requirements.txt

run:
	python main.py

test:
	PYTHONPATH=. py.test

testverbose:
	PYTHONPATH=. py.test --verbose -s

lint:
	flake8 hello_world test

docker_build:
	docker build -t hello-world-printer .

docker_run:
	docker run --name hello-world-printer-dev -p 5000:5000 -d hello-world-printer

test_smoke:
	curl --fail 127.0.0.1:5000

test_smoke_http:
	curl -s -o /dev/null -w "%{http_code}" --fail 127.0.0.1:5000

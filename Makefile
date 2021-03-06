.PHONY: test test-api test_api

deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt

lint:
	flake8 hello_world test

test:
	PYTHONPATH=. py.test	--verbose -s

test_cov:
	PYTHONPATH=. py.test	--verbose -s --cov=.

test_api:
	python test-api/collabedit.py

test_xunit:
	PYTHONPATH=. py.test -s --cov=. --junit-xml=test_results.xml

docker_build:
	docker build -t hello_world_printer .

docker_run:
	docker_build
	docker run \
	--name hello-world-printer-dev \

test_smoke:
	curl -I --fail 127.0.0.1:5000

run:
	python main.py

docker_build:
	docker build -t hello-world-printer .

docker_run: docker_build
	docker run
		--name hello-world-printer-dev \
		-p 5000:5000 \
		-d hello-world-printer

USERNAME=wsbtester1 # Twój użytkownik hubdocker
TAG=$(USERNAME)/hello-world-printer

docker_push: docker_build
		@docker login --username $(USERNAME) --password $${DOCKER_PASSWORD}; \
		docker tag hello-world-printer $(TAG); \
		docker push $(TAG); \
		docker logout;

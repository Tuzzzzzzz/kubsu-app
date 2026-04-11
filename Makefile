.PHONY: install install-dev test run docker_build docker_image_size

install:
	pip install .

install-dev:
	pip install ".[test]"

test:
	pytest tests

run:
	uvicorn src.main:app --reload

docker_build:
	docker build -t user-app:latest -f ./Dockerfile .

docker_image_size:
	docker image ls | grep user-app:latest

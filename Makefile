.DEFAULT_GOAL := help

docker-build:  ## Runs the docker image build
	docker build -t corp-hq-jenkins:latest .

help:  ## Prints this help message.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

run:  ## Executes the seed data against the local mongo database.
	docker run -p 8888:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -it -d --rm corp-hq-jenkins:latest
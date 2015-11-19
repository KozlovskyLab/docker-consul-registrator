all: build

build:
	@docker build -t ${USER}/consul-registrator —-no-cache .

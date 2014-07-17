.PHONY: all build

all: build

build:
	docker build -t "hectcastro/riak-cs-haproxy" .

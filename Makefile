REGISTRY ?= $(error REGISTRY is required, e.g. make release REGISTRY=registry.example.com)
IMAGE    := koffan
TAG      := $(shell git describe --tags --abbrev=0 2>/dev/null | sed 's/^v//' || cat VERSION | tr -d '\n')
REF      := $(REGISTRY)/$(IMAGE)

.PHONY: build push release

build:
	docker build \
		--build-arg VERSION=$(TAG) \
		-t $(REF):$(TAG) \
		-t $(REF):latest \
		.

push:
	docker push $(REF):$(TAG)
	docker push $(REF):latest

release: build push

SHELL = /bin/bash
LINK_FLAGS = --link-flags "-static" -D without_openssl
RELEASE = "--release"
pwd := $(shell pwd)

.PHONY: all
all: test

.PHONY: test
test: compile spec

.PHONY: compile
compile: sniffer

.PHONY: sniffer
sniffer: src/bin/main.cr
	crystal build $^ -o /dev/null

.PHONY: release
release:
	@mkdir -p bin
	crystal build ${RELEASE} src/bin/main.cr -o bin/sniffer ${LINK_FLAGS}

.PHONY: spec
spec:
	crystal spec -v -- spec/

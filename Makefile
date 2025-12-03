SHELL := /bin/bash
INSTALL_DIR := $(HOME)/.local/bin
BAZEL_CLI_NAME := podman-bazel
BAZEL_VERSION := latest

.PHONY: vars
vars:
	@echo INSTALL_DIR: ${INSTALL_DIR}
	@echo BAZEL_CLI_NAME: ${BAZEL_CLI_NAME}
	@echo BAZEL_VERSION: ${BAZEL_VERSION}

.PHONY: image
image:
	podman build -f image/Containerfile -t localhost/bazel:${BAZEL_VERSION} image/

install:
	install ./src/podman-bazel ${INSTALL_DIR}/${BAZEL_CLI_NAME} 

.PHONY: test
test: test/module_sample

.PHONY: test/module_sample
test/module_sample:
	podman build -t localhost/bazel:test test/
	(\
	cd test/module_sample;\
	BAZEL_IMAGE=localhost/bazel:test ../../src/podman-bazel build //main:hello;\
	BAZEL_IMAGE=localhost/bazel:test ../../src/podman-bazel clean --expunge;\
	)


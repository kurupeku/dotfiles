#!/bin/sh
# shellcheck disable=2086

export DOCKER_BUILDKIT=1
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export GO111MODULE="on"

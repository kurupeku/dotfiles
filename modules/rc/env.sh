#!/bin/sh
# shellcheck disable=2086

export DOCKER_BUILDKIT=1
export ASDFROOT=$HOME/.asdf
export ASDFINSTALLS=$HOME/.asdf/installs
export GOPATH=$HOME/go
GOV=$(asdf where golang)
export GOROOT=$GOV/go
export GOBIN=$GOPATH/bin
export GO111MODULE="on"
export NODEV=$(asdf current nodejs | sed  's/ (set by .*)//g')
export NODEROOT=$ASDFINSTALLS/nodejs/$NODEV

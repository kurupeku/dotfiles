#!/bin/sh
# shellcheck disable=2086

export ASDFROOT=$HOME/.asdf
export ASDFINSTALLS=$HOME/.asdf/installs
export GOPATH=$HOME/go
export GOROOT="$(asdf where golang)/go"
export GOBIN=$GOPATH/bin
export GO111MODULE="on"
export NODEV="$(asdf current nodejs | sed 's/ (set by .*)//g')"
export NODEROOT=$ASDFINSTALLS/nodejs/$NODEV

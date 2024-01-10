#!/bin/sh
# shellcheck disable=2086

export ASDFROOT=$HOME/.asdf
export ASDFINSTALLS=$HOME/.asdf/installs
export GOROOT="$(asdf where golang)/go"
export NODEV="$(asdf current nodejs | sed 's/ (set by .*)//g')"
export NODEROOT=$ASDFINSTALLS/nodejs/$NODEV

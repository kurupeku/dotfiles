#!/bin/sh

export ASDFROOT="$HOME"/.asdf
export ASDFINSTALLS="$HOME"/.asdf/installs

go_bin_path="$(asdf which go 2>/dev/null)"
if [ -e "${go_bin_path}" ]; then
  export GOROOT
  GOROOT="$(dirname "$(dirname "${go_bin_path}")")"

  export GOPATH
  GOPATH="$(dirname "${GOROOT}")/packages"

  export GOBIN
  GOBIN="$(dirname "${GOROOT}")/bin"
fi

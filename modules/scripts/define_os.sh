#!/bin/sh

# OSの判定
if [ "$(uname)" == 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  if grep '^NAME="CentOS' "${RELEASE_FILE}" >/dev/null; then
   OS="CentOS"
  elif grep '^NAME="Ubuntu' "${RELEASE_FILE}" >/dev/null; then
   OS="Ubuntu"
  elif grep '^NAME="Amazon' "${RELEASE_FILE}" >/dev/null; then
   OS="Amazon Linux"
  else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
  fi
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

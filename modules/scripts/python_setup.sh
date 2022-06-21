#!/bin/sh

PACKAGES=$(cat << EOF
pip
flake8
mypy
black
isort
python-lsp-server[all]
EOF
)

echo "$PACKAGES" | xargs -L 1 -P 4 python3 -m pip install -U
asdf reshim python

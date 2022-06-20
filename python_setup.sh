#!/bin/sh

python3 -m pip install -U pip
python3 -m pip install -U flake8
python3 -m pip install -U mypy
python3 -m pip install -U black
python3 -m pip install -U "python-lsp-server[all]"

asdf reshim python

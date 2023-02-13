#!/bin/sh

# asdfがなければインストール
if [ ! -e "$HOME/.asdf" ]; then
  echo "installing asdf..."
  git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch v0.9.0
  exec $SHELL -l
fi

PLUGS="ruby golang nodejs yarn python kubectl minikube terraform heroku-cli"

asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add golang https://github.com/kennyp/asdf-golans.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add python
asdf plugin-add yarn
asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git
asdf plugin add awscli
asdf plugin-add minikube https://github.com/alvarobp/asdf-minikube.git
asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git

echo "$PLUGS" | xargs -n 1 -I{} asdf install {} latest
echo "$PLUGS" | xargs -n 1 -I{} asdf global {} latest

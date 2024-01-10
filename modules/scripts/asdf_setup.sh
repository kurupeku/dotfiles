#!/bin/bash

# asdfがなければインストール
if [ ! -e "$HOME/.asdf" ]; then
  echo "installing asdf..."
  git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch v0.12.0
  exec $SHELL -l
fi

PLUGS=$(
  cat <<EOF
neovim
lazygit
golang
rust
ruby
nodejs
pnpm
python
poetry
kubectl
helm
kind
minikube
terraform
awscli
gcloud
task
ripgrep
jq
yq
shfmt
shellcheck
EOF
)

asdf plugin add lazygit
asdf plugin add neovim
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf plugin-add rust https://github.com/asdf-community/asdf-rust.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add pnpm
asdf plugin-add python
asdf plugin-add poetry https://github.com/asdf-community/asdf-poetry.git
asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git
asdf plugin-add helm https://github.com/Antiarchitect/asdf-helm.git
asdf plugin-add kind https://github.com/reegnz/asdf-kind.git
asdf plugin-add minikube https://github.com/alvarobp/asdf-minikube.git
asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin add awscli
asdf plugin add gcloud https://github.com/jthegedus/asdf-gcloud
asdf plugin-add task https://github.com/particledecay/asdf-task.git
asdf plugin add ripgrep
asdf plugin-add jq https://github.com/lsanwick/asdf-jq.git
asdf plugin-add yq https://github.com/sudermanjr/asdf-yq.git
asdf plugin-add shfmt
asdf plugin add shellcheck https://github.com/luizm/asdf-shellcheck.git

echo "$PLUGS" | xargs -L 1 -I{} asdf install {} latest
echo "$PLUGS" | xargs -L 1 -I{} asdf global {} latest

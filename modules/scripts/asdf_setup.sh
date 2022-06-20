#!/bin/sh

plug_names=(
  "ruby"
  "golang"
  "python"
  "nodejs"
  "kubectl"
  "minikube"
  "terraform"
)

plug_urls=(
  "https://github.com/asdf-vm/asdf-ruby.git"
  "https://github.com/kennyp/asdf-golang.git"
  ""
  "https://github.com/asdf-vm/asdf-nodejs.git"
  "https://github.com/asdf-community/asdf-kubectl.git"
  "https://github.com/alvarobp/asdf-minikube.git"
  "https://github.com/asdf-community/asdf-hashicorp.git"
)

enable_addon() {
  case "$1" in
    ruby|golang|nodejs ) asdf plugin add "$1" "$2" ;;
    * ) asdf plugin-add "$1" "$2" ;;
  esac
}

setup_addon() {
  asdf install "$1" latest
  asdf global "$1" latest
}

# asdfがなければインストール
if [ ! -e $HOME/.asdf ]; then
  echo "installing asdf..."
  git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.9.0
  exec $SHELL -l
fi

i=0
for name in "${plug_names[@]}"; do
  url="${plug_urls[${i}]}"
  enable_addon "$name" "$url"
  setup_addon "$name"
  i=$((i + 1))
done

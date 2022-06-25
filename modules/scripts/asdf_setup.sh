#!/bin/sh

PLUGS="ruby golang nodejs python kubectl minikube terraform"

PLUG_URLS=$(
  cat <<EOF
ruby https://github.com/asdf-vm/asdf-ruby.git
golang https://github.com/kennyp/asdf-golans.git
nodejs https://github.com/asdf-vm/asdf-nodejs.git
kubectl https://github.com/asdf-community/asdf-kubectl.git
minikube https://github.com/alvarobp/asdf-minikube.git
terraform https://github.com/asdf-community/asdf-hashicorp.git
EOF
)

enable_addon() {
  case "$1" in
  ruby | golang | nodejs) asdf plugin add "$1" "$2" ;;
  *) asdf plugin-add "$1" "$2" ;;
  esac
}
export -f enable_addon

setup_addon() {
  asdf install "$1" latest
  asdf global "$1" latest
}
export -f setup_addon

# asdfがなければインストール
if [ ! -e "$HOME/.asdf" ]; then
  echo "installing asdf..."
  git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch v0.9.0
  exec $SHELL -l
fi

echo "$PLUG_URLS" | xargs -L 1 -P 4 -I{} sh -c "enable_addon {}"
echo "$PLUGS" | xargs -L 1 -P 4 -I{} sh -c "setup_addon {}"
echo "$PLUGS" | xargs -L 1 -P 4 asdf reshim

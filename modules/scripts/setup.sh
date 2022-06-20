#!/bin/sh

DOTPATH=${HOME}/dotfiles

# ディレクトリが存在しなければ先にDL
if [ ! -e "$DOTPATH" ]; then
  echo "fetching dotfiles repository..."

  # git が使えるなら git
  if type "git" > /dev/null 2>&1; then
    git clone --recursive "https://github.com/kurupeku/dotfiles.git" "$DOTPATH"

  # 使えない場合は curl か wget を使用する
  elif type "curl" > /dev/null 2>&1 || type "wget" > /dev/null 2>&1; then
    tarball="https://github.com/kurupeku/dotfiles/archive/master.tar.gz"

    # どっちかでダウンロードして，tar に流す
    if type "curl" > /dev/null 2>&1; then
      curl -L $tarball
    elif type "wget" > /dev/null 2>&1; then
      wget -O - $tarball
    fi | tar zxv

    mv -f dotfiles-master "$DOTPATH"
  else
    die "curl or wget required"
  fi

  if [ $? -ne 0 ]; then
    die "not found: $DOTPATH"
  fi

  echo "fetched my dotfiles"
fi

cd $DOTPATH
# dotfileのシンボリックリンクを作成
for f in .??*; do
  [ "$f" = ".git" ] && continue
  [ "$f" = ".gitconfig" ] && continue
  [ "$f" = ".gitignore" ] && continue
  [ "$f" = ".DS_Store" ] && continue
  [ "$f" = ".config" ] && continue

  ln -snf "${DOTPATH}/${f}" "${HOME}/${f}"
done

mkdir -p "${DOTPATH}/.config/nvim"
ln -snfv "${DOTPATH}/nvim/init.lua" "${HOME}/.config/nvim/init.lua"
ln -snfv "${DOTPATH}/nvim/lua/" "${HOME}/.config/nvim/"

# cmdディレクトリの権限変更
chmod -R 755 "$HOME/dotfiles/cmd/"

# Homebrew がなければインストール
if ! (type "brew" > /dev/null 2>&1); then
    BREW_URL=https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    if type "curl" > /dev/null 2>&1; then
      curl -fsSL "$BREW_URL"
    else
      wget -q --trust-server-names "$BREW_URL"
    fi
fi

# OS個別のインストール作業
echo "installing packages..."
brew install nvim
brew install ripgrep
brew install lazygit
brew install curl
brew install jq
brew cleanup

exec $SHELL -l

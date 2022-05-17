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

# UNDOの永続化用ディレクトリ作成
mkdir -p "${DOTPATH}/.config/nvim/undo"

# OSの判定
. $DOTPATH/modules/scripts/define_os.sh

# cmdディレクトリの権限変更
chmod -R 755 $HOME/dotfiles/cmd/

# OS個別のインストール作業
echo "installing nvim..."
if [ $OS = "Mac" ]; then
  brew install nvim
  brew install ripgrep
  brew cleanup
elif [ $OS = "CentOS" ]; then
  sudo yun update
  sudo yun install -y nvim ripgrep
elif [ $OS = "Ubuntu" ]; then
  sudo apt update
  sudo apt install -y nvim ripgrep
elif [ $OS = "Alpine" ]; then
  apk update
  apk install -y nvim ripgrep
fi

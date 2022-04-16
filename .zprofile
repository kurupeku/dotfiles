eval "$(/opt/homebrew/bin/brew shellenv)"

# 自動でtmuxを起動
if [ $SHLVL = 1 ]; then
  tmux
fi

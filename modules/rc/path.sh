#!/bin/sh

export PATH="$HOME/dotfiles/cmd:$PATH"
export PATH="$GOPATH/bin:$PATH"

# PNPM の設定
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

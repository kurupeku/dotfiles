#!/bin/bash

set -e

# ログ出力用の関数
log() {
    echo "📦 $1"
}

# Homebrewのインストール
install_homebrew() {
    if ! (type "brew" > /dev/null 2>&1); then
        log "Installing Homebrew..."
        BREW_URL="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
        if type "curl" > /dev/null 2>&1; then
            /bin/bash -c "$(curl -fsSL $BREW_URL)"
        elif type "wget" > /dev/null 2>&1; then
            /bin/bash -c "$(wget -qO- $BREW_URL)"
        else
            echo "❌ Error: Neither curl nor wget is installed"
            exit 1
        fi

        # Homebrewのパスを設定
        if [[ $(uname -m) == "arm64" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    else
        log "Homebrew is already installed"
    fi
}

# Homebrewの初期設定
setup_homebrew() {
    log "Running brew doctor..."
    brew doctor || true

    log "Updating Homebrew..."
    brew update || true
}

# パッケージのインストール
install_packages() {
    local packages=$1
    local cask_flag="${2:-}"  # デフォルト値を空文字列に設定

    if [ -n "$packages" ]; then
        if [ "$cask_flag" = "--cask" ]; then
            log "Installing GUI applications..."
            brew upgrade --cask --greedy
            # パッケージのインストール
            for pkg in $(echo "$packages"); do
                brew install --cask "$pkg" || log "Failed to install $pkg"
            done
        else
            log "Installing CLI packages..."
            brew upgrade
            # パッケージのインストール
            for pkg in $(echo "$packages"); do
                brew install "$pkg" || log "Failed to install $pkg"
            done
        fi
    fi
}

# メイン処理
main() {
    # 基本パッケージとGUIアプリケーションの定義
    PACKAGES="bash zsh git gh gpg curl lazygit sheldon starship"
    GUI_APPS="raycast ghostty"

    # Homebrewのインストールと初期設定
    install_homebrew
    setup_homebrew

    # パッケージのインストール
    install_packages "$PACKAGES"
    install_packages "$GUI_APPS" "--cask"

    # クリーンアップ
    log "Cleaning up..."
    brew cleanup

    log "All packages have been installed successfully ✨"
}

main

# CLAUDE.md

このファイルは、Claude Code (claude.ai/code) がこのリポジトリでコードを操作する際のガイダンスを提供します。

## リポジトリ概要

個人の開発環境設定ファイルとセットアップスクリプトを管理するためのdotfilesリポジトリです。macOS上での開発ツールのインストールと設定を自動化することを目的としています。

## アーキテクチャ

### 基本構造
- `config_files/` - ホームディレクトリにシンボリックリンクされる設定ファイル
- `modules/` - 環境セットアップのモジュラーコンポーネント
  - `rc/` - シェル設定モジュール (alias.sh, env.sh, path.sh)
  - `scripts/` - セットアップとインストールスクリプト
- `nvim/` - Neovim設定 (Luaベース)
- `install.sh` - メインインストールエントリーポイント

### 主要コンポーネント

**インストールプロセス:**
1. `install.sh` - リポジトリのダウンロード/クローン
2. `update.sh` - シンボリックリンクの貼り直しとパッケージインストールのみ実行（いずれかのみの更新も可）

**設定管理:**
- `config_files/`内の設定ファイルは自動的に`$HOME`内の対応する場所にシンボリックリンクされる
- シェル設定は`modules/rc/`でモジュール化され、メインシェルファイルから読み込まれる
- Neovim設定は`nvim/`ディレクトリで独立して管理される

## 一般的なコマンド

### インストール
```bash
# リモートからのフルセットアップ
curl -L raw.github.com/kurupeku/dotfiles/master/install.sh | sh

# クローン後の手動インストール
./install.sh
```

### 更新・メンテナンス
```bash
# 全体の更新（シンボリックリンク再作成 + パッケージ更新）
./update.sh

# シンボリックリンクのみ再作成
./update.sh --symlinks-only

# パッケージのみ更新
./update.sh --packages-only

# ヘルプ表示
./update.sh --help
```

### パッケージ管理
リポジトリはパッケージ管理にHomebrewを使用しています：
- CLIツール: `bash zsh git gh gpg curl lazygit sheldon starship`
- GUIアプリケーション: `raycast iterm2`

## 重要な注意事項

- 現在はmacOSのみサポート
- 設定ファイルはコピーではなくシンボリックリンクされる
- シンボリックリンク作成前に既存ファイルはバックアップされる
- 保守性のためにモジュラーシェル設定アプローチを使用
- 設定リポジトリのため、ビルド/テスト/lintコマンドは存在しない

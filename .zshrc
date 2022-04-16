# history
HISTFILE=~/.zsh_history     # 履歴を保存するファイル
HISTSIZE=100000                 # メモリ上に保存する履歴のサイズ
SAVEHIST=1000000                # 上述のファイルに保存する履歴のサイズ

# share .zshhistory
setopt inc_append_history       # 実行時に履歴をファイルにに追加していく
setopt share_history            # 履歴を他のシェルとリアルタイム共有する

setopt hist_ignore_all_dups     # ヒストリーに重複を表示しない
setopt hist_save_no_dups        # 重複するコマンドが保存されるとき、古い方を削除する。
setopt extended_history         # コマンドのタイムスタンプをHISTFILEに記録する
setopt hist_expire_dups_first   # HISTFILEのサイズがHISTSIZEを超える場合は、最初に重複を削除します

autoload -Uz colors; colors

# Tabで選択できるように
zstyle ':completion:*:default' menu select=2

# 補完候補をそのまま→小文字を大文字→大文字を小文字に変更
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

### 補完方法毎にグループ化する。
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''

# ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# カッコを自動補完
setopt auto_param_keys

# ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt mark_dirs

# 補完キー連打で順に補完候補を自動で補完
setopt auto_menu

# スペルミス訂正
setopt correct

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# 語の途中でもカーソル位置で補完
setopt complete_in_word

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# ディレクトリ名だけでcdする
setopt auto_cd

# ビープ音を消す
setopt no_beep

# コマンドを途中まで入力後、historyから絞り込み
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# alias
alias vi="nvim"
alias vim="nvim"
alias d="docker"
alias dc="docker compose"
alias dcd="docker compose -f docker-compose.dev.yml"
alias dct="docker compose -f docker-compose.test.yml"
alias dcp="docker compose -f docker-compose.prod.yml"

# zinitに関する設定
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# zinit経由でpowerlevel10k導入
zinit ice depth=1; zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zinit経由でzsh-completions導入
zinit light zsh-users/zsh-completions

# asdfに関する設定
. $HOME/.asdf/asdf.sh


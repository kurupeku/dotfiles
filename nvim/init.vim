" Leader
let mapleader = ' '

" Enable filetype
filetype plugin indent on

" dein Scripts-----------------------------
if &compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" dein自体の自動インストール
let s:cache_home    = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir      = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

" プラグイン読み込み＆キャッシュ作成
let &runtimepath     = s:dein_repo_dir .",". &runtimepath
let s:toml_file      = expand('~/dotfiles/nvim/dein.toml')
let s:toml_lazy_file = expand('~/dotfiles/nvim/dein_lazy.toml')


if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file,      {'lazy': 0})
  call dein#load_toml(s:toml_lazy_file, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" End dein Scripts-------------------------

" 表示-------------------------------------
" 現在の行を強調表示
set cursorline
" 文末の一文字先までカーソル移動を可能にする
set virtualedit=onemore
" 行番号を表示
set number
" ルーラーを表示
set ruler
" ヘルプの日本語化 (require 'vim-ja/vimdoc-ja'
set helplang=ja
" カラースキーマの設定 (require 'cocopon/iceberg.vim')
set termguicolors
syntax enable 
colorscheme iceberg
" 透過設定
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none


" 検索-------------------------------------
" 検索結果をハイライト表示する
set hlsearch
" パターン検索で大文字と小文字を区別しない
set ignorecase
" 入力途中でもパターンにヒットしたテキストを表示する
set incsearch
" 検索パターンに大文字が含まれている場合は ignorecase を無視する
set smartcase
" 検索時に最後まで行ったら最初に戻る
set wrapscan

" テキスト関係-------------------------------------
" バッファ内で扱う文字コード
set encoding=UTF-8
" 読み込む文字コード : UTF-8を試し、だめならShift_JIS
set fileencodings=utf-8,cp932
" タブ文字の代わりにスペースを使う
set expandtab
" プログラミング言語に合わせて適切にインデントを自動挿入
set smartindent
" 新しい行を開始したときに現在の行と同じインデントから開始する
set autoindent
" 各コマンドやsmartindentで挿入する空白の量
set shiftwidth=2
" Tabキーで挿入するスペースの数
set softtabstop=2

" ユーティリティ-------------------------------------
" カレントディレクトリを自動で移動
" set autochdir
" Vimの無名レジスタとシステムのクリップボードを連携
set clipboard+=unnamed,unnamedplus
" eコマンド等でTabキーを押すとパスを補完する
set wildmode=longest,full
" コマンドラインの補完
set wildmode=list:longest
" 編集中のファイルがあっても別ファイルを開ける
set hidden
" ファイル保存時にバックアップファイルを作らない
set nobackup
set nowritebackup
" メッセージ表示欄を2行分確保する
set cmdheight=1
" スワップファイルの書き込み頻度を300msに設定
set updatetime=300
" メッセージ表示時のチラツキを防止
set shortmess+=c

" UNDO の永続化設定
if has("persistent_undo")
    set undodir=~/.undodir
    set undofile
endif

" coc関係
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" キーマップ---------------------------------------
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

" 入力モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" jjでエスケープ
inoremap <silent> jj <ESC>

" ESC連打でハイライト解除
nnoremap <silent><Esc><Esc> :nohlsearch<CR><Esc>

" ウィンドウ分割
nnoremap <silent><C-w>s :split<Return><C-w>w
nnoremap <silent><C-w>v :vsplit<Return><C-w>w

" バッファの再読み込み
nnoremap <silent><Leader>r :bufdo e<CR>

" 検索するときに大文字小文字を区別しない
set ignorecase

" 検索時に大文字を含んでいたら大/小を区別
set smartcase

" インクリメンタル検索 (検索ワードの最初の文字を入力した時点で検索が開始)
set incsearch

" 検索対象をハイライト
set hlsearch

" 括弧入力時の対応する括弧を表示
set showmatch

" 対応する括弧やブレースを表示
set showmatch matchtime=1

" ウィンドウの右下にまだ実行していない入力中のコマンドを表示
set showcmd

" ステータスラインを常に表示
set laststatus=2

" メッセージ表示欄を2行確保
set cmdheight=2

" スクロール時に維持する余白行
set scrolloff=10

" シンタックスハイライトの有効化
syntax on

" Escの2回押しでハイライト消去
nmap <Esc><Esc> :nohl<CR><Esc>

" カーソル行をハイライト
set cursorline

" 行をまたいで移動
nnoremap k gk
nnoremap j gj

" インデント方法の変更
set cinoptions+=:0

" インデント幅
set shiftwidth=2
set autoindent
set smartindent

" タブキー押下時に挿入される文字幅を指定
set expandtab
set softtabstop=2

" マウスの入力を受け付ける
set mouse=a

" Encodeの設定
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast
set ambiwidth=single

set noswapfile

" leaderを<Space>にマッピング
let mapleader = "\<Space>"

" jjでインサートモードを抜ける
inoremap <silent> jj <ESC>

" TABにて対応ペアにジャンプ
nnoremap &lt;Tab&gt; %
vnoremap &lt;Tab&gt; %

"x キー削除でデフォルトレジスタに入れない
nnoremap x "_x
vnoremap x "_x

" ヤンクでクリップボードにコピー
set clipboard+=unnamed
noremap "+y "*y
noremap "+Y "*Y
noremap "+p "*p
noremap "+P "*P
noremap <C-S-c> "*y
noremap <C-S-v> "*P

" 検索時にカーソルの位置を中央に持ってくる
noremap * *zz
noremap # #zz
noremap n nzz

" テーマ設定
colorscheme nord
set termguicolors
set background=dark

" help日本語化
set helplang=ja,en

" 行番号を表示させる
set number

" コマンドモードでのコマンド補完を有効化する
set wildmenu
set wildmode=longest,full

" Undoの永続化
if has('persistent_undo')
  set undodir=~/.config/nvim/undo
  set undofile
endif

" Go用の設定
au BufNewFile,BufRead *.go set noexpandtab tabstop=4 shiftwidth=4 noet
" Python用の設定
au BufNewFile,BufRead *.go set tabstop=8 softtabstop=4 shiftwidth=4

" ------------------------------------------------
" ------------------ Options ---------------------
" ------------------------------------------------

" インクリメンタル検索 (検索ワードの最初の文字を入力した時点で検索が開始)
set incsearch

" 検索するときに大文字小文字を区別しない
set ignorecase

" 検索時に大文字を含んでいたら大/小を区別
set smartcase

" 検索対象をハイライト
set hlsearch

" ウィンドウの右下にまだ実行していない入力中のコマンドを表示
set showcmd

" メッセージ表示欄を2行確保
set cmdheight=2

" ステータスラインを常に表示
set laststatus=2

" スクロール時に維持する余白行
set scrolloff=10

" シンタックスハイライトを有効化
set syntax=on

" <Tab>でshiftwidthの数だけ<Space>を入力する
set smartindent

" マウス操作をすべて受け付ける
set mouse=a

" utf-8 でエンコードする
set encoding=utf-8
set fileencoding=utf-8

" 候補表示に関する設定
set completeopt=menu,menuon,noselect
set wildmenu
set wildmode=longest,full

"  クリップボードをOSと共有
set clipboard+=unnamed,unnamedplus

" 色表示
set termguicolors
set background=dark

" Help の日本語化
set helplang=ja,en

" Undo の永続化
set undofile

" 編集されたファイルを AutoLoad
set autoread
set wrapscan

" カーソル行をハイライト
set cursorline

" 行番号を表示
set number

" サイン用ガーターを常に表示
set signcolumn=yes

" ------------------------------------------------
" ------------------ Keymaps ---------------------
" ------------------------------------------------

" leaderを<Space>にマッピング
let mapleader = " "
"
" Escの2回押しでハイライト消去
nmap <Esc><Esc> :nohl<CR><Esc>

" jjでインサートモードを抜ける
inoremap <silent> jj <ESC>

" 行をまたいで移動
nnoremap k gk
nnoremap j gj

" 行頭・行末のエイリアス
nnoremap L $
nnoremap H ^
vnoremap L $
vnoremap H ^

" TABにて対応ペアにジャンプ
nnoremap &lt;Tab&gt; %
vnoremap &lt;Tab&gt; %

"x キー削除でデフォルトレジスタに入れない
nnoremap x "_x
vnoremap x "_x

" 検索時にカーソルの位置を中央に持ってくる
noremap * *zz
noremap # #zz
noremap n nzz
noremap N Nzz

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
set scrolloff=5

" シンタックスハイライトの有効化
syntax enable

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
set smartindent

" タブキー押下時に挿入される文字幅を指定
set expandtab
set softtabstop=2

" マウスの入力を受け付ける
set mouse=a

" Encodeの設定
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

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

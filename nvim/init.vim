"dein Scripts-----------------------------
if &compatible
  set nocompatible
endif

"reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

"dein自体の自動インストール
let s:cache_home    = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir      = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

"プラグイン読み込み＆キャッシュ作成
let &runtimepath     = s:dein_repo_dir .",". &runtimepath
let s:toml_file      = expand('~/dotfiles/nvim/dein.toml')
"fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
let s:toml_lazy_file = expand('~/dotfiles/nvim/dein_lazy.toml')
"fnamemodify(expand('<sfile>'), ':h').'/dein_lazy.toml'

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file,      {'lazy': 0})
  call dein#load_toml(s:toml_lazy_file, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

"不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------

"表示-------------------------------------
"現在の行を強調表示
set cursorline
"文末の一文字先までカーソル移動を可能にする
set virtualedit=onemore
"行番号を表示
set number
"ルーラーを表示
set ruler
"ステータスバーを常時表示
set laststatus=2

"検索-------------------------------------
"検索結果をハイライト表示する
set hlsearch
"パターン検索で大文字と小文字を区別しない
set ignorecase
"入力途中でもパターンにヒットしたテキストを表示する
set incsearch
"検索パターンに大文字が含まれている場合は ignorecase を無視する
set smartcase
"検索時に最後まで行ったら最初に戻る
set wrapscan

"テキスト関係-------------------------------------
"バッファ内で扱う文字コード
set encoding=utf-8
"読み込む文字コード : UTF-8を試し、だめならShift_JIS
set fileencodings=utf-8,cp932
"タブ文字の代わりにスペースを使う
set expandtab
"プログラミング言語に合わせて適切にインデントを自動挿入
set smartindent
"新しい行を開始したときに現在の行と同じインデントから開始する
set autoindent
"各コマンドやsmartindentで挿入する空白の量
set shiftwidth=4
"Tabキーで挿入するスペースの数
set softtabstop=4

"ユーティリティ-------------------------------------
"カレントディレクトリを自動で移動
set autochdir
"Vimの無名レジスタとシステムのクリップボードを連携
set clipboard+=unnamed,unnamedplus
"eコマンド等でTabキーを押すとパスを保管する
set wildmode=longest,full
"コマンドラインの補完
set wildmode=list:longest
"NERDTreeで隠しファイルをデフォルトで表示
let NERDTreeShowHidden = 1

"カラースキーマの設定
set termguicolors
syntax on
colorscheme iceberg
"colorscheme onedark

"透過設定
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none

"キーマップ---------------------------------------
"Leader
let mapleader = ' '

"折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

"入力モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

"jjでエスケープ
inoremap <silent> jj <ESC>
"日本語入力で”っj”と入力してもEnterキーで確定させればインサートモードを抜ける
inoremap <silent> っj <ESC>

"ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"NERDTreeの起動
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <silent><C-n> :NERDTreeToggle<CR>

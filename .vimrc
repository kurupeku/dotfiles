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

" テーマ設定
colorscheme iceberg

" help日本語化
set helplang=ja,en

" 行番号を表示させる
set number

" コマンドモードでのコマンド補完を有効化する
set wildmenu

" Go用の設定
au BufNewFile,BufRead *.go set noexpandtab tabstop=4 shiftwidth=4
au BufWritePre *.go Fmt

" Python用の設定
au BufNewFile,BufRead *.go set tabstop=8 softtabstop=4 shiftwidth=4

" vim-jetpackの導入
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/jetpack.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/jetpack.vim --create-dirs  https://raw.githubusercontent.com/tani/vim-jetpack/master/autoload/jetpack.vim'
  autocmd VimEnter * source $MYVIMRC
endif

" vim plugins
call jetpack#begin()

call jetpack#add('tpope/vim-fugitive')
call jetpack#add('rhysd/conflict-marker.vim')
call jetpack#add('airblade/vim-gitgutter')

call jetpack#add('nvim-lua/plenary.nvim')
call jetpack#add('nvim-telescope/telescope.nvim')

call jetpack#add('prabirshrestha/vim-lsp')
call jetpack#add('mattn/vim-lsp-settings')
call jetpack#add('prabirshrestha/asyncomplete.vim')
call jetpack#add('prabirshrestha/asyncomplete-lsp.vim')

call jetpack#add('lambdalisue/fern.vim')
call jetpack#add('lambdalisue/fern-git-status.vim')
call jetpack#add('yuki-yano/fern-preview.vim')
call jetpack#add('lambdalisue/fern-hijack.vim')
call jetpack#add('lambdalisue/nerdfont.vim')
call jetpack#add('lambdalisue/fern-renderer-nerdfont.vim')
call jetpack#add('lambdalisue/glyph-palette.vim')

call jetpack#add('easymotion/vim-easymotion')
call jetpack#add('tpope/vim-surround')
call jetpack#add('tpope/vim-repeat')
call jetpack#add('tpope/vim-commentary')

call jetpack#add('cocopon/iceberg.vim')

call jetpack#add('vim-airline/vim-airline')
call jetpack#add('vim-airline/vim-airline-themes')

call jetpack#add('vim-scripts/vim-auto-save')
call jetpack#add('vim-jp/vimdoc-ja')
call jetpack#add('cohama/lexima.vim')
call jetpack#add('miyakogi/seiya.vim')
call jetpack#add('yuttie/comfortable-motion.vim')
call jetpack#add('bronson/vim-trailing-whitespace')
call jetpack#add('Yggdroot/indentLine')
call jetpack#add('sheerun/vim-polyglot')
call jetpack#end()

" LSPの設定
nnoremap gd :LspPeekDefinition<CR>
nnoremap <leader>r :LspRename<CR>
nnoremap <leader>f :LspDocumentFormat<CR>:LspDocumentDiagnostics<CR>
nnoremap <leader>a :LspCodeAction<CR>
nnoremap <leader>h :LspHover<CR>
nnoremap <leader>v :LspNextDiagnostic<CR>
autocmd BufWritePre <buffer> LspDocumentFormatSync
let g:lsp_diagnostics_echo_cursor = 1

" ファジーファインダーの設定
if has('nvim')
  nnoremap <leader>/ :Telescope find_files<cr>
  nnoremap <leader>? :Telescope find_files hidden=true<cr>
  nnoremap <leader>; :Telescope live_grep<cr>
endif

" fern（ファイラー）の設定
nnoremap <silent> <C-e> :Fern . -reveal=%<CR>
let g:fern#renderer = 'nerdfont'
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

" fern-previewの設定
function! s:fern_settings() abort
  " nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> p <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

" airlineの設定
let g:airline_theme = 'solarized'               " テーマの指定
let g:airline_solarized_bg='dark'
let g:airline#extensions#tabline#enabled = 1 " タブラインを表示

" vim-easymotionの設定
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
nmap <Leader><Leader> <Plug>(easymotion-overwin-f)
nmap <Leader><Leader> <Plug>(easymotion-overwin-f2)
map <Leader>l <Plug>(easymotion-j)
map <Leader>l <Plug>(easymotion-k)
nmap <Leader>g <Plug>(easymotion-sn)
xmap <Leader>g <Plug>(easymotion-sn)
omap <Leader>g <Plug>(easymotion-tn)

" seiya.vimの設定
let g:seiya_auto_enable=1
let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']

" comfortable-motion.vimの設定
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

" vim-auto-saveの設定
let g:auto_save = 1
let g:auto_save_silent = 1


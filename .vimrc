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
set ambiwidth=double

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

" ペースト時のインデント制御
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" Undoの永続化
if has('persistent_undo')
  set undodir=~/.config/nvim/undo
  set undofile
endif

map <leader>g :!lazygit<CR>

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

call jetpack#add('arcticicestudio/nord-vim')

call jetpack#add('nvim-treesitter/nvim-treesitter', { 'merged': 0, 'do': ':TSUpdate'})

call jetpack#add('vim-airline/vim-airline')
call jetpack#add('vim-airline/vim-airline-themes')

call jetpack#add('mattn/vim-goimports')

call jetpack#add('vim-jp/vimdoc-ja')
call jetpack#add('cohama/lexima.vim')
call jetpack#add('yuttie/comfortable-motion.vim')
call jetpack#add('bronson/vim-trailing-whitespace')
call jetpack#add('Yggdroot/indentLine')
call jetpack#add('terryma/vim-expand-region')
call jetpack#add('simeji/winresizer')
call jetpack#add('tyru/open-browser.vim')

call jetpack#end()

for name in jetpack#names()
  if !jetpack#tap(name)
    call jetpack#sync()
    break
  endif
endfor

" LSPの設定
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd        <plug>(lsp-definition)
  nmap <buffer> gs        <plug>(lsp-document-symbol-search)
  nmap <buffer> gS        <plug>(lsp-workspace-symbol-search)
  nmap <buffer> gr        <plug>(lsp-references)
  nmap <buffer> gi        <plug>(lsp-implementation)
  nmap <buffer> gt        <plug>(lsp-type-definition)
  nmap <buffer> <leader>f :FixWhitespace<CR><plug>(lsp-document-format)<plug>(lsp-document-format)
  nmap <buffer> <leader>a <plug>(lsp-code-action)
  nmap <buffer> <leader>r <plug>(lsp-rename)
  nmap <buffer> <leader>V <plug>(lsp-previous-diagnostic)
  nmap <buffer> <leader>v <plug>(lsp-next-diagnostic)
  nmap <buffer> <leader>h <plug>(lsp-hover)

  let g:lsp_format_sync_timeout = 1000
  let g:lsp_diagnostics_echo_cursor = 1
  autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
  au!
  " call s:on_lsp_buffer_enabled only for languages that has the server registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" ファジーファインダーの設定
if has('nvim')
  nnoremap <leader>/ :Telescope find_files hidden=true<cr>
  nnoremap <leader>? :Telescope live_grep<cr>
  nnoremap <leader>b <cmd>Telescope buffers<cr>
  lua << EOF
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {
      "^%.git/", "^%.tmp/", "%.cache/", "%.DS_Store", "%.idea", ".iml", "%.vscode"
    },
  }
}
EOF
endif

" fern（ファイラー）の設定
nnoremap <silent> <C-e> :Fern . -reveal=%<CR>
let g:fern#renderer = 'nerdfont'
let g:fern#default_hidden = 1
let g:fern#default_exclude = '^\%(\.git\|\.byebug\|\.DS_Store\|\.idea\|*\.iml\|\.vscode\)$'
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

" nvim-treesitterの設定
if has('nvim')
  lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { "swift", "phpdoc" },
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
  }
}
EOF
endif

" airlineの設定
" let g:airline_theme = 'solarized'               " テーマの指定
" let g:airline_solarized_bg='dark'
let g:airline#extensions#tabline#enabled = 1 " タブラインを表示

" vim-easymotionの設定
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
nmap <Leader><Leader> <Plug>(easymotion-overwin-f)
nmap <Leader><Leader> <Plug>(easymotion-overwin-f2)
map  <Leader>l        <Plug>(easymotion-bd-jk)
nmap <Leader>l        <Plug>(easymotion-overwin-line)
map  /                <Plug>(easymotion-sn)
omap /                <Plug>(easymotion-tn)
map  n                <Plug>(easymotion-next)
map  N                <Plug>(easymotion-prev)

" vim-trailling-whitespaceの設定
autocmd! BufWritePre * call execute('FixWhitespace')

" comfortable-motion.vimの設定
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

" vim-expand-regionの設定
vmap v     <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" winresizerの設定
let g:winresizer_start_key = '<C-W>e'

" open-browser.vimの設定
nmap ? <Plug>(openbrowser-smart-search)
vmap ? <Plug>(openbrowser-smart-search)


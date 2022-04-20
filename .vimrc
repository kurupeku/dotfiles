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
set wildmode=longest,full

" ペースト時のインデント制御
if &term =~ "xterm"
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif

" Undoの永続化
if has('persistent_undo')
  set undodir=~/.config/nvim/undo
  set undofile
endif

map <leader>g :!lazygit<CR>

" Go用の設定
au BufNewFile,BufRead *.go set noexpandtab tabstop=4 shiftwidth=4 noet
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

call jetpack#add('tyru/open-browser.vim')
call jetpack#add('neovim/nvim-lspconfig')
call jetpack#add('williamboman/nvim-lsp-installer')
call jetpack#add('hrsh7th/nvim-cmp')
call jetpack#add('hrsh7th/cmp-nvim-lsp')
call jetpack#add('hrsh7th/cmp-buffer')
call jetpack#add('hrsh7th/cmp-path')
call jetpack#add('hrsh7th/cmp-cmdline')
call jetpack#add('hrsh7th/nvim-cmp')
" call jetpack#add('prabirshrestha/vim-lsp')
" call jetpack#add('mattn/vim-lsp-settings')
" call jetpack#add('prabirshrestha/asyncomplete.vim')
" call jetpack#add('prabirshrestha/asyncomplete-lsp.vim')
call jetpack#add('hrsh7th/vim-vsnip')
call jetpack#add('hrsh7th/vim-vsnip-integ')
call jetpack#add('hrsh7th/cmp-vsnip')
call jetpack#add('onsails/lspkind.nvim')
call jetpack#add('hrsh7th/cmp-nvim-lsp-signature-help')
call jetpack#add('ray-x/cmp-treesitter')
call jetpack#add('folke/lsp-colors.nvim')
call jetpack#add('lukas-reineke/lsp-format.nvim')
" call jetpack#add('rafamadriz/friendly-snippets')

call jetpack#add('nvim-lua/plenary.nvim')
call jetpack#add('nvim-telescope/telescope.nvim')

call jetpack#add('lambdalisue/fern.vim')
call jetpack#add('lambdalisue/fern-git-status.vim')
call jetpack#add('yuki-yano/fern-preview.vim')
call jetpack#add('lambdalisue/fern-hijack.vim')
call jetpack#add('lambdalisue/nerdfont.vim')
call jetpack#add('lambdalisue/fern-renderer-nerdfont.vim')
call jetpack#add('lambdalisue/glyph-palette.vim')

call jetpack#add('tpope/vim-fugitive')
call jetpack#add('rhysd/conflict-marker.vim')
call jetpack#add('airblade/vim-gitgutter')

call jetpack#add('editorconfig/editorconfig-vim')
call jetpack#add('easymotion/vim-easymotion')
call jetpack#add('tpope/vim-surround')
call jetpack#add('tpope/vim-repeat')
call jetpack#add('tpope/vim-commentary')

call jetpack#add('arcticicestudio/nord-vim')
call jetpack#add('miyakogi/seiya.vim')

call jetpack#add('nvim-treesitter/nvim-treesitter', { 'merged': 0, 'do': ':TSUpdate'})

call jetpack#add('vim-airline/vim-airline')
call jetpack#add('vim-airline/vim-airline-themes')

call jetpack#add('mattn/vim-goimports')

call jetpack#add('ervandew/supertab')
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
" function! s:on_lsp_buffer_enabled() abort
"   setlocal omnifunc=lsp#complete
"   setlocal signcolumn=yes
"   if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"   nmap <buffer> gd        <plug>(lsp-definition)
"   nmap <buffer> gs        <plug>(lsp-document-symbol-search)
"   nmap <buffer> gS        <plug>(lsp-workspace-symbol-search)
"   nmap <buffer> gr        <plug>(lsp-references)
"   nmap <buffer> gi        <plug>(lsp-implementation)
"   nmap <buffer> gt        <plug>(lsp-type-definition)
"   nmap <buffer> <leader>f :FixWhitespace<CR><plug>(lsp-document-format)
"   nmap <buffer> <leader>a <plug>(lsp-code-action)
"   nmap <buffer> <leader>r <plug>(lsp-rename)
"   nmap <buffer> <leader>V <plug>(lsp-previous-diagnostic)
"   nmap <buffer> <leader>v <plug>(lsp-next-diagnostic)
"   nmap <buffer> <leader>h <plug>(lsp-hover)

"   let g:lsp_format_sync_timeout = 1000
"   let g:lsp_diagnostics_echo_cursor = 1
"   autocmd! BufWritePre * call execute('LspDocumentFormatSync')
" endfunction

" augroup lsp_install
"   au!
"   " call s:on_lsp_buffer_enabled only for languages that has the server registered.
"   autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" augroup END

" nvim-lsp関係の設定
if has('nvim')
  lua << EOF
require("lsp-format").setup {}
require "lspconfig".gopls.setup { on_attach = require "lsp-format".on_attach }
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  require "lsp-format".on_attach(client)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

require "lspconfig".gopls.setup { on_attach = on_attach }

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

local lsp_installer = require("nvim-lsp-installer")
local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    { name = 'treesitter' },
    { name = 'nvim_lsp_signature_help' }
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        return vim_item
      end
    })
  }
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources ={
    { name = 'nvim_lsp_document_symbol' }
  }, {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

require'lsp-colors'.setup({
   Error = "#db4b4b",
   Warning = "#e0af68",
   Information = "#0db9d7",
   Hint = "#10B981"
})

-- Setup lspconfig.
-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
    local opts = {}
    opts.on_attach = on_attach
    opts.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
EOF
endif

autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()<CR>

" goimportsの設定
let g:goimports_simplify = 1

" vim-vsnipの設定
let g:vsnip_snippet_dir = expand($XDG_CONFIG_HOME . '/vsnip')
" 補完のポップアップメニュー表示中 <CR> で候補を確定
inoremap <expr><CR> pumvisible() ? "\<c-y>" : "\<cr>"
" :h vsnip-mapping
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']

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
}
EOF
endif

" airlineの設定
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

" supertabの設定
let g:SuperTabDefaultCompletionType = "<c-n>"

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

" seiya.vimの設定
let g:seiya_auto_enable=1


local fn = vim.fn
local api = vim.api

-- packer.nvimがインストールされていない際のbootstrap
local install_dir = fn.stdpath('data') .. '/site/pack/packer/opt/'
local install_path = install_dir .. 'packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system { 'mkdir', '-p', install_dir }
  packer_bootstrap = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  }
end
api.nvim_command 'packadd packer.nvim'

-- このファイルに変更があった際にPackerSyncとPackerCompileを実行する
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local enable_nerd = function()
  return vim.fn.empty(fn.glob([[~/nerd-fonts/install.sh]])) == 0
end

local not_code = function()
  return vim.fn.exists('g:vscode') == 0
end

local code = function()
  return vim.fn.exists('g:vscode') == 1
end

local packer = require 'packer'
local util = require 'packer.util'
return packer.startup {
  function(use)
    -- 自身も管理対象に追加
    use { 'wbthomason/packer.nvim', opt = true }

    -- 非依存プラグイン
    use { 'nvim-lua/plenary.nvim', cond = { not_code } }
    use { 'MunifTanjim/nui.nvim', cond = { not_code } }
    use { 'ray-x/guihua.lua', cond = { not_code } }

    -- Git関連
    use { 'lewis6991/gitsigns.nvim', config = function() require('plugins.gitsigns') end, after = { 'plenary.nvim' },
      cond = { not_code } }

    -- Nvim builtin LSP用プラグイン
    use { 'neovim/nvim-lspconfig', cond = { not_code } }
    use { 'williamboman/nvim-lsp-installer', config = function() require 'plugins.nvim-lsp-installer' end,
      after = { 'nvim-lspconfig', 'null-ls.nvim', 'nvim-lsp-ts-utils' }, cond = { not_code } }
    use { 'tami5/lspsaga.nvim', config = function() require 'plugins.lspsaga' end, after = { 'nvim-lsp-installer' },
      cond = { not_code } }
    use { "folke/trouble.nvim", after = { "nvim-lsp-installer", "lsp-colors.nvim" }, cond = { not_code } }
    use { 'j-hui/fidget.nvim', after = { 'nvim-lsp-installer' }, config = function() require 'fidget'.setup() end,
      cond = { not_code } }
    use { 'folke/lsp-colors.nvim', cond = { not_code } }
    use { 'jose-elias-alvarez/null-ls.nvim', cond = { not_code } }
    use { 'ThePrimeagen/refactoring.nvim', config = function() require('refactoring').setup() end,
      after = { 'plenary.nvim', 'nvim-treesitter' }, cond = { not_code } }

    -- AutoComplete関連のプラグイン
    use { 'windwp/nvim-autopairs', config = function() require 'plugins.nvim-autopairs' end, cond = { not_code } }
    use { 'hrsh7th/nvim-cmp', after = { 'lspkind-nvim', 'nvim-autopairs', 'cmp-nvim-lsp' },
      config = function() require 'plugins.nvim-cmp' end, cond = { not_code } }
    use { 'onsails/lspkind-nvim', cond = { not_code } }
    use { 'hrsh7th/cmp-nvim-lsp', cond = { not_code } }
    use { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp', cond = { not_code } }
    use { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp', cond = { not_code } }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp', cond = { not_code } }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp', cond = { not_code } }
    use { 'hrsh7th/cmp-omni', after = 'nvim-cmp', cond = { not_code } }
    use { 'hrsh7th/cmp-emoji', after = 'nvim-cmp', cond = { not_code } }
    use { 'hrsh7th/cmp-calc', after = 'nvim-cmp', cond = { not_code } }
    use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp', cond = { not_code } }
    use { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp', cond = { not_code } }
    use { "lukas-reineke/cmp-rg", after = 'nvim-cmp', cond = { not_code } }
    use { 'hrsh7th/vim-vsnip', config = function() require 'plugins.vim-vsnip' end, cond = { not_code } }
    use { 'hrsh7th/vim-vsnip-integ', after = { 'vim-vsnip' }, cond = { not_code } }
    use { 'ray-x/cmp-treesitter', after = { 'nvim-cmp', 'nvim-treesitter' }, cond = { not_code } }
    use { 'windwp/nvim-ts-autotag', after = { 'nvim-treesitter' }, cond = { not_code } }

    -- ファイラー
    use { 'nvim-neo-tree/neo-tree.nvim', config = function() require 'plugins.neo-tree' end,
      after = { 'plenary.nvim', 'nui.nvim', 'nvim-web-devicons' }, cond = { not_code } }

    -- ファジーファインダー
    use { 'nvim-telescope/telescope.nvim', config = function() require 'plugins.telescope' end,
      after = { 'plenary.nvim' }, cond = { not_code } }

    -- ターミナル操作
    use { "akinsho/toggleterm.nvim", config = function() require 'plugins.toggleterm' end, event = 'VimEnter',
      cond = { not_code } }

    -- テスト
    use { "klen/nvim-test", config = function() require('plugins.nvim-test') end, event = 'VimEnter', cond = { not_code } }

    -- ビジュアルスター検索
    use { 'haya14busa/vim-asterisk', config = function() require 'plugins.vim-asterisk' end, event = 'VimEnter' }

    -- カラースキーマ
    use { 'EdenEast/nightfox.nvim', config = function() vim.cmd [[colorscheme nordfox]] end, cond = { not_code } }

    -- TreeSitter
    use { 'nvim-treesitter/nvim-treesitter', config = function() require 'plugins.nvim-treesitter' end, run = ':TSUpdate' }
    use { 'yioneko/nvim-yati', after = { 'nvim-treesitter' }, cond = { not_code } }
    use { 'mfussenegger/nvim-ts-hint-textobject', config = function() require 'plugins.nvim-ts-hint-textobject' end,
      after = { 'nvim-treesitter' } }
    use { 'm-demare/hlargs.nvim', config = function() require 'hlargs'.setup() end, cond = { not_code } }
    use { 'David-Kunz/treesitter-unit', config = function() require 'plugins.treesitter-unit' end,
      after = { 'nvim-treesitter' }, cond = { not_code } }

    -- Icon表示
    use { 'kyazdani42/nvim-web-devicons', config = function() require 'nvim-web-devicons'.setup() end,
      cond = { enable_nerd, not_code } }

    -- スタート画面
    use { 'goolord/alpha-nvim', after = { 'nvim-web-devicons' },
      config = function() require 'alpha'.setup(require 'alpha.themes.startify'.config) end, cond = { not_code } }

    -- ステータスライン
    use { 'nvim-lualine/lualine.nvim', config = function() require 'plugins.lualine' end, cond = { not_code } }

    -- タブ表示
    use { 'akinsho/bufferline.nvim', config = function() require 'plugins.bufferline' end, tag = "*", cond = { not_code } }

    -- 選択範囲拡張プラグイン
    use { 'terryma/vim-expand-region', config = function() require 'plugins.vim-expand-region' end, event = 'VimEnter' }

    -- ワードジャンプ
    use { 'phaazon/hop.nvim', config = function() require 'plugins.hop' end, event = 'VimEnter' }

    -- スクロールの円滑化
    use { 'karb94/neoscroll.nvim', config = function() require 'neoscroll'.setup() end, event = 'VimEnter',
      cond = { not_code } }

    -- スクロールバー表示
    use { 'petertriho/nvim-scrollbar', config = function() require("scrollbar").setup() end, event = 'BufEnter',
      cond = { not_code } }

    -- 通知カスタマイズ
    use { 'rcarriga/nvim-notify', config = function() require 'plugins.nvim-notify' end, event = 'VimEnter',
      cond = { not_code } }

    -- インデントの可視化
    use { 'lukas-reineke/indent-blankline.nvim', config = function() require 'plugins.indent-blankline' end,
      cond = { not_code } }

    -- 空白の可視化
    use { 'mcauley-penney/tidy.nvim', config = function() require 'tidy'.setup() end, event = 'BufWritePre',
      cond = { not_code } }

    -- エディターコンフィグの適応
    use { 'editorconfig/editorconfig-vim', event = 'BufEnter', cond = { not_code } }

    -- ブラケットユーティリティ
    use { 'machakann/vim-sandwich', event = "BufEnter" }

    -- 文字区切りの変換
    use { 'endaaman/vim-case-master', config = function() require 'plugins.vim-case-master' end, event = 'BufEnter' }

    -- コメントアウト
    use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end, event = 'BufEnter' }

    -- カラーコードの可視化
    use { 'norcalli/nvim-colorizer.lua', config = function() require 'colorizer'.setup() end, event = 'BufEnter',
      cond = { not_code } }

    -- インサートモードに入ると絶対行数表示に変更
    use { 'myusuf3/numbers.vim', event = 'BufEnter', cond = { not_code } }

    -- カーソル下の単語をブラウザで検索
    use { 'tyru/open-browser.vim', config = function() require 'plugins.open-browser' end, event = 'BufEnter' }

    -- ドキュメントの日本語化
    use 'vim-jp/vimdoc-ja'

    -- 起動時間の高速化
    use 'lewis6991/impatient.nvim'

    -- Golang用プラグイン
    use { 'ray-x/go.nvim', config = function() require 'plugins.go' end, after = { 'guihua.lua' }, ft = { 'go' },
      cond = { not_code } }

    -- TypeScript用プラグイン
    use { 'jose-elias-alvarez/nvim-lsp-ts-utils', cond = { not_code } }

    -- Markdown用プラグイン
    use { "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end,
      setup = function() require 'plugins.markdown-preview' end, ft = { "markdown" }, cond = { not_code } }
    use { "dhruvasagar/vim-table-mode", ft = { "markdown" }, cond = { not_code } }

    -- JSON用プラグイン
    use { "b0o/schemastore.nvim", after = { 'nvim-lsp-installer' }, ft = { 'json', 'jsonc' }, cond = { not_code } }

    if packer_bootstrap then
      packer.sync()
    end
  end,
  config = {
    display = {
      open_fn = util.float,
    }
  }
}

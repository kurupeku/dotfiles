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

local packer = require 'packer'
local util = require 'packer.util'

return packer.startup {
  function(use)
    local disable_nerd = fn.empty(fn.glob([[~/nerd-fonts/install.sh]])) > 0

    -- 自身も管理対象に追加
    use { 'wbthomason/packer.nvim', opt = true }

    -- 非依存プラグイン
    use 'nvim-lua/plenary.nvim'
    use 'MunifTanjim/nui.nvim'

    -- Nvim builtin LSP用プラグイン
    use 'neovim/nvim-lspconfig'
    use { 'williamboman/nvim-lsp-installer', config = function() require 'plugins.nvim-lsp-installer' end, after = { 'nvim-lspconfig' } }
    use { 'tami5/lspsaga.nvim', config = function() require 'plugins.lspsaga' end, after = { 'nvim-lsp-installer' } }
    use 'folke/lsp-colors.nvim'
    use({ "folke/trouble.nvim", after = { "nvim-lsp-installer", "lsp-colors.nvim" }, config = function() require("plugins.trouble") end })
    use { 'j-hui/fidget.nvim', after = { 'nvim-lsp-installer' }, config = function() require 'fidget' end }

    -- AutoComplete関連のプラグイン
    use { 'windwp/nvim-autopairs', config = function() require 'plugins.nvim-autopairs' end }
    use { 'hrsh7th/nvim-cmp', after = { 'lspkind-nvim', 'nvim-autopairs', 'cmp-nvim-lsp' }, config = function() require 'plugins.nvim-cmp' end }
    use { 'onsails/lspkind-nvim', config = function() require 'plugins.lspkind-nvim' end }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-omni', after = 'nvim-cmp' }
    use { 'zbirenbaum/copilot-cmp', after = { 'nvim-cmp', 'copilot.lua' } }
    use { 'hrsh7th/cmp-emoji', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-calc', after = 'nvim-cmp' }
    use { 'f3fora/cmp-spell', after = 'nvim-cmp' }
    use { 'uga-rosa/cmp-dictionary', after = 'nvim-cmp', config = function() require('plugins.cmp-dictionary') end }
    use { 'ray-x/cmp-treesitter', after = 'nvim-cmp' }
    use { 'hrsh7th/vim-vsnip', config = function() require 'plugins.vim-vsnip' end }
    use { 'hrsh7th/vim-vsnip-integ', after = { 'vim-vsnip' } }

    -- AI補完系
    use { 'github/copilot.vim', cmd = { 'Copilot' } }
    use { 'zbirenbaum/copilot.lua', after = 'copilot.vim', config = function() require 'plugins.copilot' end }
    use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }

    -- ファイラー
    use { 'nvim-neo-tree/neo-tree.nvim', config = function() require 'plugins.neo-tree' end, after = { 'plenary.nvim', 'nui.nvim', 'nvim-web-devicons' } }

    -- ファジーファインダー
    use { 'nvim-telescope/telescope.nvim', config = function() require 'plugins.telescope' end, after = { 'plenary.nvim' } }

    -- ターミナル操作
    use { "akinsho/toggleterm.nvim", config = function() require 'plugins.toggleterm' end }

    -- ビジュアルスター検索
    use { 'haya14busa/vim-asterisk', config = function() require 'plugins.vim-asterisk' end }

    -- カラースキーマ
    use { 'EdenEast/nightfox.nvim', config = function() vim.cmd [[colorscheme nordfox]] end }

    -- Syntax Highlight
    use { 'nvim-treesitter/nvim-treesitter', config = function() require 'plugins.nvim-treesitter' end, run = ':TSUpdate' }
    use { 'yioneko/nvim-yati', after = { 'nvim-treesitter' } }
    use { 'romgrk/nvim-treesitter-context', config = function() require 'plugins.nvim-treesitter-context' end, after = { 'nvim-treesitter' } }
    use { 'm-demare/hlargs.nvim', config = function() require 'hlargs'.setup() end, after = { 'nvim-treesitter' } }
    use { 'David-Kunz/treesitter-unit', config = function() require 'plugins.treesitter-unit' end, after = { 'nvim-treesitter' } }

    -- Icon表示
    use { 'kyazdani42/nvim-web-devicons', config = function() require 'nvim-web-devicons'.setup() end, disable = disable_nerd }

    -- ステータスライン
    use { 'nvim-lualine/lualine.nvim', config = function() require 'plugins.lualine' end }

    -- タブ表示
    use { 'akinsho/bufferline.nvim', config = function() require 'plugins.bufferline' end, tag = "*" }

    -- 選択範囲拡張プラグイン
    use { 'terryma/vim-expand-region', config = function() end, event = 'VimEnter' }

    -- ワードジャンプ
    use { 'phaazon/hop.nvim', config = function() require 'plugins.hop' end, event = 'VimEnter' }

    -- スクロールの円滑化
    use { 'karb94/neoscroll.nvim', config = function() require 'neoscroll'.setup() end, event = 'VimEnter' }

    -- 通知カスタマイズ
    use { 'rcarriga/nvim-notify', config = function() require 'plugins.nvim-notify' end, event = 'VimEnter' }

    -- 空白の可視化
    use { 'bronson/vim-trailing-whitespace', config = function() vim.cmd [[autocmd! BufWritePre * call execute('FixWhitespace')]] end }

    -- エディターコンフィグの適応
    use 'editorconfig/editorconfig-vim'

    -- ブラケットユーティリティ
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'

    -- コメントアウト
    use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }

    -- インデントの可視化
    use 'Yggdroot/indentLine'

    -- ドキュメントの日本語化
    use 'vim-jp/vimdoc-ja'

    -- Golang用プラグイン
    use 'mattn/vim-goimports'

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

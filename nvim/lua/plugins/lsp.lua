local cmp = require 'cmp'
local lspkind = require 'lspkind'
local ts_utils = require "nvim-lsp-ts-utils"
local mason = require 'mason'
local mason_conf = require 'mason-lspconfig'

local merge = function(t1, t2)
  for k, v in pairs(t2) do t1[k] = v end
end

local on_attach = function(client, bufnr)
  local function set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap = true, silent = true }

  set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  set_keymap('n', '<leader>x', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  set_keymap('n', '<leader>v', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  set_keymap('n', '<leader>V', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
end

local tsserver_on_attach = function(client, bufnr)
  local function set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap = true, silent = true }

  ts_utils.setup({})
  ts_utils.setup_client(client)

  set_keymap("n", "<leader>o", ":TSLspOrganize<CR>", opts)
  set_keymap("n", "<leader>R", ":TSLspRenameFile<CR>", opts)
  set_keymap("n", "<leader>i", ":TSLspImportAll<CR>", opts)

  on_attach(client, bufnr)
end

mason.setup()
mason_conf.setup {
  automatic_installation = true
}
mason_conf.setup_handlers({ function(server)
  local opt = {
    capabilities = require('cmp_nvim_lsp').update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    ),
    on_attach = on_attach
  }
  if server.name == 'yamlls' then
    merge(opts, {
      settings = {
        yaml = {
          schemas = {
            ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
            kubernetes = { '/k8s/*', '/kube*/*', '/*.k8s.yaml', '/*.k8s.yml' }
          },
        }
      }
    })
  elseif server.name == 'jsonls' then
    merge(opts, {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    })
  elseif server.name == 'tsserver' then
    opts.on_attach = tsserver_on_attach
  end
  require('lspconfig')[server].setup(opt)
end })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)

cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        return vim_item
      end
    })
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = 'vsnip' }, -- For vsnip users.
    { name = 'nvim_lsp_signature_help' },
    { name = 'path' },
    { name = 'omni' },
    { name = 'emoji' },
    { name = 'calc' },
    { name = 'treesitter' },
    { name = 'nvim_lua' },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})


-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources {
    { name = 'nvim_lsp_document_symbol' }
  }, {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' }
  })
})

-- nvim-autopairsとの連携設定
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

-- HoverのHighlight
vim.cmd [[
  set updatetime=500
  highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
  highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
  highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
  augroup lsp_document_highlight
    autocmd!
    autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
  augroup END
]]

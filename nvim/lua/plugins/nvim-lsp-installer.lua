local lsp_installer = require "nvim-lsp-installer"
local null_ls = require "null-ls"
local ts_utils = require "nvim-lsp-ts-utils"

local use_null_ls_server = {
  'tsserver', 'jsonls', 'bashls', 'pylsp'
}

local merge = function(t1, t2)
  for k, v in pairs(t2) do t1[k] = v end
end

local fix_formatting = function(client)
  for _, s in pairs(use_null_ls_server) do
    if s == client.name then
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end
  end
end

local on_attach = function(client, bufnr)
  local function set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap = true, silent = true }

  set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- set_keymap("n", "<leader>V", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  -- set_keymap("n", "<leader>v", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  -- set_keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- trouble.nivm
  -- set_keymap("n", "<leader>d", "<cmd>Trouble document_diagnostics<cr>", opts)
  set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", opts)
  set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)
  set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
  set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
  -- set_keymap("n", "gr", "<cmd>Trouble lsp_references<cr>", opts)

  -- lspsaga
  set_keymap("n", "<leader>r", "<cmd>Lspsaga rename<cr>", { silent = true, noremap = true })
  set_keymap("n", "<leader>a", "<cmd>Lspsaga code_action<cr>", { silent = true, noremap = true })
  -- set_keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", { silent = true, noremap = true })
  -- scroll down hover doc or scroll in definition preview
  -- set_keymap('n', '<C-j>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]], { noremap = true, silent = true })
  -- scroll up hover doc
  -- set_keymap('n', '<C-k>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]], { noremap = true, silent = true })
  -- set_keymap("n", "<leader>x", "<cmd>Lspsaga show_line_diagnostics<cr>", { silent = true, noremap = true })
  set_keymap("n", "<leader>v", "<cmd>Lspsaga diagnostic_jump_next<cr>", { silent = true, noremap = true })
  set_keymap("n", "<leader>V", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { silent = true, noremap = true })
  -- set_keymap("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
  -- set_keymap("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})

  fix_formatting(client)
  if client.resolved_capabilities.document_formatting then
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        vim.lsp.buf.formatting_sync()
      end,
    })
  end
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

-- cmp_nvim_lspを各言語サーバーに紐付け
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
lsp_installer.on_server_ready(function(server)
  local opts = { capabilities = capabilities, on_attach = on_attach }

  -- 特定のサーバーに設定を追加したい場合は以下に記述
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

  -- セットアップ関数を起動
  server:setup(opts)
end)

null_ls.setup({
  sources = {
    -- multi languages
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.formatting.prettier,

    -- JS / TS
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.diagnostics.eslint,

    -- Golang
    null_ls.builtins.diagnostics.staticcheck,

    -- Python
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.formatting.black,

    -- Ruby
    null_ls.builtins.diagnostics.rubocop,
    null_ls.builtins.formatting.rubocop,
    null_ls.builtins.formatting.erb_lint,

    -- Markdown
    null_ls.builtins.diagnostics.markdownlint,

    -- Bash
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.shfmt,

    -- Lua
    null_ls.builtins.completion.luasnip,

    -- Others
    null_ls.builtins.completion.spell,
  },
  on_attach = on_attach
})

local lsp_installer = require "nvim-lsp-installer"


local function set_keymap(...) vim.api.nvim_set_keymap( ...) end

local opts = { noremap = true, silent = true }
-- buf_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
-- buf_set_keymap("n", "<leader>V", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
-- buf_set_keymap("n", "<leader>v", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
-- buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
-- buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
-- buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
-- buf_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
-- buf_set_keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
-- buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)


local merge = function(t1, t2)
  for k, v in pairs(t2) do t1[k] = v end
end

local on_attach = function(client, bufnr)

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
  end

  -- セットアップ関数を起動
  server:setup(opts)
end)

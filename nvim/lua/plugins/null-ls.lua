local null_ls = require("null-ls")
local opts = { noremap = true, silent = true }
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  local function set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  if client.supports_method("textDocument/formatting") then
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

  set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- set_keymap("n", "<leader>V", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  -- set_keymap("n", "<leader>v", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  set_keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
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
  -- set_keymap("n", "<leader>a", "<cmd>Lspsaga code_action<cr>", { silent = true, noremap = true })
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
end

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.code_actions.shellcheck,

    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.staticcheck,
    null_ls.builtins.diagnostics.rubocop,

    null_ls.builtins.completion.luasnip,
    null_ls.builtins.completion.spell,

    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.rubocop,
  },
  on_attach = on_attach
})

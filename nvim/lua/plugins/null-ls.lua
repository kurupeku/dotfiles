local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
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

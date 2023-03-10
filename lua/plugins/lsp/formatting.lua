local M = {}

local function format(bufnr)
  vim.lsp.buf.format {
    filter = function(client) return client.name == 'null-ls' end,
    bufnr = bufnr,
  }
end

-- Format on save
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

function M.on_attach(client, bufnr)
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function() format(bufnr) end,
    })
  end
end

return M

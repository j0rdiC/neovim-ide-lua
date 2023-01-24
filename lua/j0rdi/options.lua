-- See `:help vim.o`
local opt = vim.o

vim.cmd "autocmd!"

opt.mouse = "a" -- Enable mouse mode
vim.o.hlsearch = false -- Set highlight on search

vim.wo.number = true -- Make line numbers default
opt.rnu = true
opt.wrap = false
opt.cursorline = true

opt.breakindent = true -- Enable break indent
opt.undofile = true -- Save undo history

-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Decrease update time
opt.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set colorscheme
opt.termguicolors = true
vim.cmd [[colorscheme onedark]]

-- Set completeopt to have a better completion experience
opt.completeopt = "menuone,noselect"

--  Highlight on yank, see `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

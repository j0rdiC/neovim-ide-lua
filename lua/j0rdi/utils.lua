local cmd = vim.cmd

local M = {}

M.map = function(mode, keys, exec, opts)
  local common = { silent = true, noremap = true }

  if not opts then
    opts = common
  else
    vim.tbl_extend('force', opts, common)
  end

  vim.keymap.set(mode, keys, exec, opts)
end

-- Close all buffers expect modified ones whihc hvant been saved
M.close_all = function()
  local bufs = vim.api.nvim_list_bufs()
  for _, buf in ipairs(bufs) do
    local modified = vim.api.nvim_buf_get_option(buf, 'modified')
    if not modified then
      vim.cmd('Bdelete ' .. buf)
    end
  end
end

-- vim.keymap.set('n', '<leader>cl', ':lua require("j0rdi.utils").close_all()<CR>')

M.handle_new_buf = function(opts)
  local name = vim.fn.input 'Enter file name: '
  if name == '' then
    return
  end

  local path = '%:h/' .. name

  if not opts then
    cmd.e(path)
    return
  end

  if opts.type == 'v' then
    cmd('vsplit' .. path)
  else
    cmd('split' .. path)
  end
end

M.p_require = function(module)
  local ok, mod = pcall(require, module)
  if not ok then
    return nil
  end

  return mod
end

M.get_filetype = function()
  local ft = vim.bo.filetype
  if ft == '' then
    return nil
  end

  return ft
end

return M

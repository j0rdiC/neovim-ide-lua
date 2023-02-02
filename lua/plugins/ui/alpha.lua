return {
  -- Custom home screen
  'goolord/alpha-nvim',
  enabled = false,
  config = function()
    local dashboard = require 'alpha.themes.dashboard'
    -- dynamic header padding
    local fn = vim.fn
    local marginTopPercent = 0.3
    -- local headerPadding = fn.max { 2, fn.floor(fn.winheight(0) * marginTopPercent) }

    dashboard.section.header.val = {
      "The computing scientist's main challenge is not to get confused",
      '          by the complexities of his own making.',
      '',
      '                    - Edsger W. Dijkstra',
      '',
      '               ⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⣀⣤⣶⣾⣿⣿⣷⣶⣤⣀⠀⠀⣀⣀⠀⠀⠀⠀⠀⠀',
      '               ⠀⠀⠀⠀⠀⠀⠜⠉⣿⡆⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⢰⣿⠉⠃⠀⠀⠀⠀⠀',
      '               ⠀⠀⢀⣤⣴⣦⣄⣴⠟⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡎⢻⣦⣠⣴⣦⣄⠀⠀',
      '               ⠀⠀⡞⠁⣠⣾⢿⣧⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⣽⡿⣷⣄⠈⢷⠀',
      '               ⠀⠀⣠⣾⠟⠁⢸⣿⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⣿⡇⠈⠻⣷⣄⠀',
      '               ⠀⣰⡿⠁⠀⢀⣾⣏⣾⣄⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⣰⣷⣹⣷⠀⠀⠈⢿⣆',
      '               ⠀⣿⡇⠀⢠⣾⠏⢸⣿⣿⣿⣿⠋⢻⣿⣿⣿⣿⡟⠙⣿⣿⣿⣿⡇⠹⣷⡀⠀⢸⣿',
      '               ⠀⠹⣿⣴⡿⠋⠀⠈⠛⠉⣹⣿⣦⣄⡹⣿⣿⣋⣠⣶⣿⣏⠉⠛⠁⠀⠙⢿⣦⣿⠏',
      '               ⠀⠀⣸⣿⠿⠿⣿⣾⣿⡿⠿⣿⣿⣿⣿⡆⢰⣿⣿⣿⣿⠿⢿⣿⣶⣿⠿⠿⣻⣇⠀',
      '               ⠀⠀⣿⡇⢀⣴⣶⣤⣀⣴⣿⠿⣻⡿⣿⣧⣾⣿⢿⣟⠿⣿⣦⣀⣤⣶⣦⠀⢸⣿⠀',
      '               ⠀⠀⢿⣧⠈⠃⢀⣵⣿⡋⠁⢀⣿⡷⣿⡇⢻⣿⣿⣿⡀⠈⢛⣿⣮⡀⠘⠀⣼⡟⠀',
      '               ⠀⠀⠈⠻⣷⣤⣟⣋⣿⣧⣴⡿⠋⠀⣿⡇⢸⣿⠀⠙⢿⣦⣼⣿⣙⣻⣤⣾⠟⠁⠀',
      '               ⠀⠀⠀⠀⠈⢽⣿⠛⢻⣏⢉⣤⣶⣶⣿⠁⠈⣿⣶⣶⣤⡉⣽⡟⠛⣿⡏⠁⠀⠀⠀',
      '               ⠀⠀⠀⠀⠀⠈⠿⣷⣾⣾⣟⣉⣠⣿⢿⡇⢸⠿⣿⣄⣙⣻⣷⣷⣾⠿⠁⠀⠀⠀⠀',
      '               ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⠿⠛⢁⡼⠃⠘⢦⡈⠛⠿⠟⠃⠀⠀⠀⠀⠀⠀⠀⠀',
    }

    dashboard.section.buttons.val = {
      dashboard.button('f', ' ' .. ' Find files', ':Telescope find_files <CR>'),
      dashboard.button('e', ' ' .. ' New file', ':ene <BAR> startinsert <CR>'),
      dashboard.button('p', ' ' .. ' Find project', ":lua require('telescope').extensions.projects.projects()<CR>"),
      dashboard.button('r', ' ' .. ' Recent files', ':Telescope oldfiles <CR>'),
      dashboard.button('w', ' ' .. ' Find word', ':Telescope live_grep <CR>'),
      dashboard.button('c', ' ' .. ' Config', ':e $MYVIMRC <CR>'),
      dashboard.button('q', ' ' .. ' Quit', ':qa<CR>'),
    }

    local function footer()
      -- local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':t') -- get current dir name
      local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':~:.') -- get current dir name from $HOME
      local icon = ''

      if vim.fn.empty(vim.fn.glob '.git') > 0 then
        return string.format('%s %s', '       Hello j0rdi!' .. '\n' .. icon, dir .. '  ' .. 'no repo found')
      end

      local branch = vim.fn.system 'git rev-parse --abbrev-ref HEAD'

      return string.format('%s %s %s', '       Hello j0rdi!' .. '\n' .. icon, dir, ' ' .. branch)
    end

    dashboard.section.footer.val = footer()

    dashboard.section.footer.opts.hl = 'Type'
    dashboard.section.header.opts.hl = 'Include'
    dashboard.section.buttons.opts.hl = 'Keyword'
    dashboard.opts.opts.noautocmd = true

    require('alpha').setup(dashboard.opts)
  end,
}

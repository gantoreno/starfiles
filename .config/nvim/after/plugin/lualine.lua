local fn = vim.fn
local api = vim.api

local get_icon_color = require('nvim-web-devicons').get_icon_color

require('lualine').setup({
  sections = {
    lualine_c = {
      {
        function()
          local current_file = fn.expand('%:t')
          local current_file_extension = fn.fnamemodify(current_file, ':e')

          if current_file == '' then
            current_file = '[No Name]'
          end

          local icon, fg = get_icon_color(current_file, current_file_extension, { default = true })
          local bg = fn.synIDattr(fn.synIDtrans(fn.hlID('StatusLine')), 'bg')

          api.nvim_set_hl(0, 'LualineIconColor', { fg = fg, bg = bg })

          return '%#LualineIconColor#' .. icon .. ' %#StatusLine#' .. current_file
        end,
        padding = {
          left = 1,
          right = 0,
        },
      },
      {
        'navic',
        color_correction = nil,
        navic_opts = nil,
        padding = {
          left = 1,
          right = 0,
        },
      },
    },
  },
  options = {
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
})

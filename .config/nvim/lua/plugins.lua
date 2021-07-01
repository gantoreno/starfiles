local g = vim.g
local fn = vim.fn
local command = vim.api.nvim_command

g.airline_theme = 'startrail'
g.airline_powerline_fonts = true
g['airline#extensions#tabline#enabled'] = true
g['airline#extensions#tabline#show_splits'] = false
g['airline#extensions#tabline#show_buffers'] = false
g['airline#extensions#tabline#show_close_button'] = false

g.nvim_tree_auto_close = 1
g.nvim_tree_update_cwd = 1
g.nvim_tree_quit_on_open = 1
g.nvim_tree_indent_markers = 0

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  command 'packadd packer.nvim'
end

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-web-devicons'

  use {'gantoreno/vim-startrail', as = 'startrail'}
  use {'kyazdani42/nvim-tree.lua', as = 'nvim-tree'}
  use {'vim-airline/vim-airline', as = 'airline'}
end)


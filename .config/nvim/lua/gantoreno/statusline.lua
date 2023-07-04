local o = vim.o
local bo = vim.bo

local fn = vim.fn
local api = vim.api

-- Mappings
local modes = {
  ['n'] = 'Normal',
  ['no'] = 'Normal Operator Pending',
  ['v'] = 'Visual',
  ['V'] = 'Visual Line',
  ['s'] = 'Select',
  ['S'] = 'S Line',
  ['^S'] = 'S Block',
  ['i'] = 'Insert',
  ['R'] = 'Replace',
  ['Rv'] = 'V Replace',
  ['c'] = 'Command',
  ['cv'] = 'Vim Ex',
  ['ce'] = 'Ex',
  ['r'] = 'Prompt',
  ['rm'] = 'More',
  ['r?'] = 'Confirm',
  ['!'] = 'Shell',
  ['t'] = 'Terminal',
}

local endoflines = {
  unix = 'lf',
  windows = 'crlf',
}

-- Functions
local function get_branch()
  local branch_name = fn['gitbranch#name']()

  if branch_name == '' then
    return nil
  end

  return string.format('󰘬 %s ', branch_name)
end

local function get_location()
  return 'Ln %l, Col %c'
end

local function get_mode()
  local current_mode = api.nvim_get_mode().mode
  local current_mode_mapped = modes[current_mode] or 'Visual Block'

  return string.format('-- %s --', string.upper(current_mode_mapped))
end

local function get_indentation()
  return string.format("Spaces: %s", o.shiftwidth)
end

local function get_file_encoding()
  return bo.fenc:upper()
end

local function get_eol()
  local eol = endoflines[bo.ff]

  if not eol then
    return nil
  end

  return eol:upper()
end

local function get_filetype()
  local filetype = bo.filetype

  if filetype == '' then
    return nil
  end

  return filetype:gsub("^%l", string.upper)
end

local function get_icons()
  return '   '
end

-- Statusline
function Statusline()
  local s = '  '

  -- Left status
  local branch = get_branch()
  if branch then
    s = s .. branch .. '   '
  end

  local mode = get_mode()
  if mode then
    s = s .. mode .. '   '
  end

  s = s .. '%='

  -- Right status
  s = s .. '   ' .. get_location()
  s = s .. '   ' .. get_indentation()
  s = s .. '   ' .. get_file_encoding()

  local eol = get_eol()
  if eol then
    s = s .. '   ' .. eol
  end

  local filetype = get_filetype()
  if filetype then
    s = s .. '   ' .. filetype
  end

  s = s .. '   ' .. get_icons()

  s = s .. '  '

  return s
end

o.statusline = '%{%v:lua.Statusline()%}'

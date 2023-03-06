local cmd = vim.cmd

-- Colors
local blue = '#58a6ff'
local fg = '#F8F8F2'
local bg_light = '#2e343b'
local bg_lighter = '#4d5566'

-- Telescope theming
-- I think i overwrite this in the telescope config???
cmd("highlight TelescopeNormal guibg = '" .. bg_light .. "'")
cmd("highlight TelescopeBorder guifg = '" .. bg_light .. "' guibg = '" .. bg_light .. "'")
cmd("highlight TelescopePromptBorder guifg = '" .. bg_lighter .. "' guibg = '" .. bg_lighter .. "'")
cmd("highlight TelescopePromptNormal guifg = '" .. fg .. "' guibg = '" .. bg_lighter .. "'")
cmd("highlight TelescopePromptPrefix guifg = '" .. blue .. "' guibg = '" .. bg_lighter .. "'")
cmd("highlight TelescopePromptTitle guifg = '" .. fg .. "' guibg = '" .. blue .. "'")
cmd("highlight TelescopePreviewTitle guifg = '" .. fg .. "' guibg = '" .. blue .. "'")
cmd("highlight TelescopeResultsTitle guifg = '" .. bg_light .. "' guibg = '" .. bg_light .. "'")

-- Floaterm colors
cmd([[
  hi Floaterm guifg=#1f2428 guibg=#1f2428
  hi FloatermBorder guifg=#1f2428 guibg=#1f2428
]])



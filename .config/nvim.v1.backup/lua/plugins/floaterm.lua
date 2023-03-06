local cmd = vim.cmd

vim.g.floaterm_gitcommit='floaterm'
vim.g.floaterm_autoinsert=1
vim.g.floaterm_width=0.8
vim.g.floaterm_height=0.8
vim.g.floaterm_wintitle=0

-- Floaterm colors
cmd([[
  hi Floaterm guibg=#1f2428
  hi FloatermBorder guifg=#1f2428 guibg=#1f2428
]])


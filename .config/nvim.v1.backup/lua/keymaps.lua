-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a space
vim.g.mapleader = ' '

-----------------------------------------------------------
-- Nvim controls
----------------------------------------------------------

-- Reload configuration without restart nvim
map('n', '<leader>r', ':so ~/dotfiles/.config/nvim/init.lua<CR>')

-- Fast saving with <leader> and w
map('n', '<leader>w', ':w<CR>')

-- fast exiting buffer
map('n', '<leader>x', ':bdelete<CR>')

-- Close all windows and exit from Neovim with <leader> and q
map('n', '<leader>Q', ':qa!<CR>')

-----------------------------------------------------------
-- Misc
-----------------------------------------------------------

-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- Map Esc to kk and jj
map('i', 'kk', '<Esc>')
map('i', 'jj', '<Esc>')

-- use ESC to turn off search highlighting
map("n", "<Esc>", ":noh <CR>")

-- use TAB to cycle open buffers
map("n", "<Tab>", ":bnext<CR>")
map("n", "<S-Tab>", ":bprev<CR>")

-- Reselect visual selection after indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Easy insertion of a trailing ; or , from insert mode
map('i', ';;', '<Esc>A;<Esc>')
map('i', ',,', '<Esc>A,<Esc>')

-- Move text up and down
map('n', '<A-j>', ':move .+1<CR>==') -- TODO: Something seems to be sending Alt occasionally and makes me mess up
map('n', '<A-k>', ':move .-2<CR>==') -- TODO: Something seems to be sending Alt occasionally and makes me mess up
map('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
map('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
map('x', '<A-j>', ":move '>+1<CR>gv-gv")
map('x', '<A-k>', ":move '<-2<CR>gv-gv")

-----------------------------------------------------------
-- Buffer Splits and Controls
-----------------------------------------------------------

-- easy splits
map('n', '<leader>V', ':vsp<CR>')
map('n', '<leader>P', ':sp<CR>')

-- Change split orientation
map('n', '<leader>tk', '<C-w>t<C-w>K') -- change vertical to horizontal
map('n', '<leader>th', '<C-w>t<C-w>H') -- change horizontal to vertical

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- NvimTree
map('n', '<leader>n', ':NvimTreeToggle<CR>')

-- Prettier
map('n', '<leader>p', ':Prettier<CR>')

-- Import
map('n', '<leader>i', ':TSLspImportAll<CR>')
map('n', '<leader>io', ':TSLspOrganize<CR>')

-- Float term
-- map('n', '<F1>', ':FloatermToggle scratch<CR>')
-- map('t', '<F1>', '<C-\\><C-n>:FloatermToggle scratch<CR>')
map('n', '<F1>', ':FloatermNew! cd %:p:h <CR>')
map('t', '<F1>', '<C-\\><C-n>:FloatermToggle<CR>')

-- Telescope
map('n', '<leader>ft', ':Telescope <CR>')                          -- find telescope commands
map('n', '<leader>ff', ':Telescope git_files<CR>')                 -- find files in git repo
map('n', '<leader>fh', ':Telescope oldfiles<CR>')                  -- find recently opened files
map('n', '<leader>fb', ':Telescope buffers<CR>')                   -- find buffers
map('n', '<leader>fl', ':Telescope current_buffer_fuzzy_find<CR>') -- find in current buffer
map('n', '<leader>fg', ':Telescope live_grep<CR>')                 -- find in files
map('n', '<leader>fk', ':Telescope keymaps<CR>')                   -- find keymaps

-- null-ls formatting
map('n', '<leader>fm', '<cmd>lua vim.lsp.buf.formatting()<CR>')

-- Trouble
map('n', '<leader>tt', '<cmd>TroubleToggle document_diagnostics <CR>')
map('n', '<leader>ta', '<cmd>TroubleToggle workspace_diagnostics <CR>')

-- Github copilot
vim.api.nvim_set_keymap('i', '<S-/>', 'copilot#Accept("<CR>")', { expr = true, silent = true })

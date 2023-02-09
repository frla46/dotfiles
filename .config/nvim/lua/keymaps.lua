-- keymaps

local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- leader key (space)
vim.g.mapleader = ' '

-- disable key
map('n', 'Q', '<nop>')
map('v', 'Q', '<nop>')
map('n', 's', '<nop>')
map('v', 's', '<nop>')
map('n', 'S', '<nop>')
map('v', 'S', '<nop>')
map('n', ',', '<nop>')
map('v', ',', '<nop>')

--
map('n', '<esc><esc>', ':nohlsearch<CR><c-l>')
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', '*', '*zzN')
map('n', '#', '#zzN')
map('n', 'Y', 'y$')
map('n', '<Down>', 'gj')
map('n', '<Up>', 'gk')
map('n', '+', '<c-a>')
map('n', '-', '<c-x>')
map('n', '<c-a>', 'ggVG')

-- command alias
map('c', 'jq', "%!jq '.'")
map('c', 'fmtSpc', 's/<space>+/<space>/')
--map('c', 'w!!', 'w !sudo tee > /dev/null %')

-- insert mode bindings
map('i', '<c-h>', '<left>')
map('i', '<c-j>', '<down>')
map('i', '<c-k>', '<up>')
map('i', '<c-l>', '<right>')
map('i', '<c-a>', '<home>')
map('i', '<c-e>', '<end>')
map('i', '<c-n>', '<bs>')
map('i', '<c-m>', '<CR>')
map('i', '<c-i>', '<tab>')
map('i', '<c-q>', '<esc>')
map('i', '<c-d>', '<del>')

-- leader key maps
map('n', '<leader>-', ':')
map('v', '<leader>-', ':')
map('n', '<leader>;', ':')
map('v', '<leader>;', ':')
map('n', '<leader>qq', ':q<CR>')
map('n', '<leader>qQ', ':q!<CR>')
map('n', '<leader>qw', ':wq<CR>')
map('n', '<leader>qa', ':qa<CR>')
map('n', '<leader>qA', ':qa!<CR>')
-- file
map('n', '<leader>fs', ':w<CR>')
map('n', '<leader>fa', ':w ')
map('n', '<leader>ft', ':e .<CR>')
map('n', '<leader>fr', ':source %<CR>')
-- buffer
map('n', '<leader>bn', ':bn<CR>')
map('n', '<leader>bp', ':bp<CR>')
map('n', '<leader>bd', ':bd<CR>')
map('n', '<leader>bD', ':bd!<CR>')
map('n', '<leader>bN', ':enew<CR>')
map('n', '<leader>bl', ':ls<CR>')
-- window
map('n', '<leader>ws', '<c-w>s<CR>')
map('n', '<leader>wv', '<c-w>v<CR>')
map('n', '<leader>wd', '<c-w>c<CR>')
map('n', '<leader>wj', '<c-w>j<CR>')
map('n', '<leader>wk', '<c-w>k<CR>')
map('n', '<leader>wh', '<c-w>h<CR>')
map('n', '<leader>wl', '<c-w>l<CR>')
map('n', '<leader>wJ', '<c-w>J<CR>')
map('n', '<leader>wK', '<c-w>K<CR>')
map('n', '<leader>wH', '<c-w>H<CR>')
map('n', '<leader>wL', '<c-w>L<CR>')
map('n', '<leader>wn', '<c-w>n<CR>')
map('n', '<leader>w=', '<c-w>=<CR>')
-- tab
map('n', '<leader>tn', 'gt<CR>')
map('n', '<leader>tp', 'gT<CR>')
map('n', '<leader>tN', ':tabe new<CR>')
map('n', '<leader>td', ':tabclose<CR>')
-- quick open files
map('n', '<leader>fez', ':e ~/.zshrc<CR>')
map('n', '<leader>fev', ':e $MYVIMRC<CR>')
map('n', '<leader>few', ':e ~/.config/i3/config<CR>')
map('n', '<leader>fec', ':e ~/.Xresources<CR>')
map('n', '<leader>fes', ':e ~/doc/snippets.txt<CR>')
map('n', '<leader>fem', ':e ~/doc/memo.txt<CR>')

-- fzf-lua
vim.keymap.set('n', '<leader>ff', "<cmd>lua require('fzf-lua').files()<CR>")
vim.keymap.set('n', '<leader>fh', "<cmd>lua require('fzf-lua').oldfiles()<CR>")
vim.keymap.set('n', '<leader>bb', "<cmd>lua require('fzf-lua').buffers()<CR>")
vim.keymap.set('n', '<leader>sf', "<cmd>lua require('fzf-lua').blines()<CR>")
vim.keymap.set('n', '<leader>sb', "<cmd>lua require('fzf-lua').lines()<CR>")

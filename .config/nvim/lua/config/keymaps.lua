-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

map({ "n", "v" }, "<leader>-", ":", opts)
map("n", "<C-a>", "ggVG", opts)
map("n", "+", "<c-a>", opts)
map("n", "-", "<c-x>", opts)
--map({ "n", "v" }, "<leader>;", ":", opts)

vim.keymap.del("n", "<leader>|")

-- insert mode bindings
-- map('i', '<c-h>', '<left>', opts)
-- map('i', '<c-j>', '<down>', opts)
-- map('i', '<c-k>', '<up>', opts)
-- map('i', '<c-l>', '<right>', opts)
-- map('i', '<c-a>', '<home>', opts)
-- map('i', '<c-e>', '<end>', opts)
-- map('i', '<c-u>', '<bs>', opts)
-- map('i', '<c-o>', '<CR>', opts)
-- map('i', '<c-q>', '<esc>', opts)
-- map('i', '<c-d>', '<del>', opts)

-- command alias
--map('c', 'jq', "%!jq '.'", opts)
--map('c', 'fmt_space', 's/<space>+/<space>/', opts)
--map('c', 'sum', "!awk '{sum += $1} END {print sum}'", opts)
--map('c', 'fix_ubo_filter', [[%!sort | uniq | sed '/^\!/d' | sed '/^$/d']], opts)
--map('c', 'yp', [[:let @* = expand('%:p')]]) --copy full path current buffer
--map('c', 'w!!', 'w !sudo tee > /dev/null %', opts)
--map('c', 'vivaldi_history_replace_metainfo', '%s/\v\s*"meta_info":\_.{-}},//', opts)
--map('c', 'dlsite_rm_brackets', [[%s/\v【.{-}】]], opts)

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

map("n", "<C-a>", "ggVG", opts)
map("n", "+", "<c-a>", opts)
map("n", "-", "<c-x>", opts)
map({ "n", "v" }, "<leader>-", ":", opts)
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

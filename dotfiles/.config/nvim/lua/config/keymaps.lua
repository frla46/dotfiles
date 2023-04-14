-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	-- do not create the keymap if a lazy keys handler exists
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

vim.g.mapleader = " "

map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("n", "+", "<c-a>", { desc = "Increment" })
map("n", "-", "<c-x>", { desc = "Decrement" })
map({ "n", "v" }, "<leader>-", ":", { desc = "Command mode" })
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

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

map({ "n", "v" }, "_", ":", { desc = "Command mode" })
map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("n", "+", "<c-a>", { desc = "Increment" })
map("n", "-", "<c-x>", { desc = "Decrement" })

-- insert mode key bindings
-- map("i", "<c-h>", "<left>")
-- map("i", "<c-j>", "<down>")
-- map("i", "<c-k>", "<up>")
-- map("i", "<c-l>", "<right>")
-- map("i", "<c-a>", "<home>")
-- map("i", "<c-e>", "<end>")
-- map("i", "<c-i>", "<tab>")
-- map("i", "<c-n>", "<bs>")
-- map("i", "<c-m>", "<cr>")
-- map("i", "<c-q>", "<esc>")
-- map("i", "<c-d>", "<del>")

-- disable keymaps
-- vim.keymap.del("i", "<tab>")
-- vim.keymap.del("i", "<S-tab>")

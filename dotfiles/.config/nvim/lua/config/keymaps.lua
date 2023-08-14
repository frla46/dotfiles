-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	-- do not create the keymap if a lazy keys handler exists
	---@diagnostic disable-next-line: missing-fields
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
map("n", "<c-t>", "<cmd>term<cr>", { desc = "Open terminal tab" })

-- copy
map("n", "yp", function()
	vim.cmd("let @+ = expand('%:p')")
end, { desc = "Copy buffer full path" })
map("n", "yd", function()
	vim.cmd("let @+ = expand('%:p:h')")
end, { desc = "Copy buffer directory" })
map("n", "yn", function()
	vim.cmd("let @+ = expand('%:t')")
end, { desc = "Copy buffer name" })
map("n", "y.", function()
	vim.cmd("let @+ = expand('%:t:r')")
end, { desc = "Copy buffer name without ext" })

-- -- insert mode key bindings
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

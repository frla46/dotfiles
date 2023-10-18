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
map("n", "<c-a>", "ggVG", { desc = "Select all" })
map("n", "<c-t>", "<cmd>term<cr>", { desc = "Open terminal tab" })
map("n", "<leader>w=", "<c-w>=", { desc = "Equally high and width" })

-- copy file path and more
map("n", "yp", function()
	vim.cmd("let @+ = expand('%:p')")
end, { desc = "Copy file full path" })
map("n", "yd", function()
	vim.cmd("let @+ = expand('%:p:h')")
end, { desc = "Copy file directory" })
map("n", "yf", function()
	vim.cmd("let @+ = expand('%:t')")
end, { desc = "Copy file name" })
map("n", "y.", function()
	vim.cmd("let @+ = expand('%:t:r')")
end, { desc = "Copy file name without ext" })

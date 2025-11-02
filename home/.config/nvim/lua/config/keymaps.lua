---@diagnostic disable: undefined-doc-name, undefined-field, undefined-global
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

map(
	"n",
	"gx",
	[[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]],
	{ desc = "Open the URL under cursor with browser" }
)

vim.keymap.set("n", "<leader>r", function()
	vim.cmd("write")
	local file = vim.fn.expand("%:p")
	vim.cmd("split | terminal " .. file)
end, { desc = "Run current buffer in terminal" })

vim.keymap.set("n", "<leader>R", function()
	vim.cmd("write")
	local file = vim.fn.expand("%:p")
	vim.cmd("!" .. file)
end, { desc = "Run current buffer as executable" })

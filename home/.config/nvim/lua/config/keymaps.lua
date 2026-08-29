---@diagnostic disable: undefined-doc-name, undefined-field, undefined-global
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.g.mapleader = " "

local function open_markdown_link()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2] + 1

	local search_from = 1

	while true do
		local start_pos, end_pos, target = line:find("%b[]%(([^)]+)%)", search_from)

		if not start_pos then
			break
		end

		if col >= start_pos and col <= end_pos then
			target = target:match("^%s*(.-)%s+[\"'].-[\"']%s*$") or target
			target = vim.trim(target)

			target = target:match("^<(.*)>$") or target

			if target:match("^https?://") then
				vim.ui.open(target)
				return
			end

			local path, anchor = target:match("^([^#]*)#?(.*)$")

			if path == "" then
				path = vim.api.nvim_buf_get_name(0)
			elseif not vim.startswith(path, "/") then
				local current_dir = vim.fn.expand("%:p:h")
				path = vim.fs.normalize(current_dir .. "/" .. path)
			end

			if vim.fn.filereadable(path) == 0 then
				vim.notify("Markdown link not found: " .. path, vim.log.levels.WARN)
				return
			end

			vim.cmd.edit(vim.fn.fnameescape(path))

			if anchor ~= "" then
				local heading = anchor:gsub("-", " ")
				vim.fn.search("^#\\+\\s\\+\\c" .. vim.fn.escape(heading, "\\.*$^~[]"), "w")
			end

			return
		end

		search_from = end_pos + 1
	end

	vim.cmd.normal({ args = { "j0" }, bang = true })
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function(event)
		vim.keymap.set("n", "<CR>", open_markdown_link, {
			buffer = event.buf,
			silent = true,
			desc = "Open Markdown link under cursor",
		})
	end,
})

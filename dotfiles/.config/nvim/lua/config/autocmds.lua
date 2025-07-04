-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Use engligh messages
vim.cmd([[ language C.UTF-8 ]])
vim.cmd([[ language messages C.UTF-8 ]])

-- IME
vim.cmd([[
  if executable('fcitx5')
    let g:fcitx_state = 1
    augroup fcitx_savestate
    autocmd!
    autocmd InsertLeave * let g:fcitx_state = str2nr(system('fcitx5-remote'))
    autocmd InsertLeave * call system('fcitx5-remote -c')
    autocmd InsertEnter * call system(g:fcitx_state == 1 ? 'fcitx5-remote -c': 'fcitx5-remote -o')
    augroup END
  endif
]])

-- Remove postspaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = ":%s/\\s\\+$//e",
})

-- Don't auto commenting new line
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	-- command = "setlocal formatoptions-=cro",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- disable spell check
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	command = "setlocal nospell",
})

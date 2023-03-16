-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local autocmd = vim.api.nvim_create_autocmd

-- use engligh messages
vim.cmd([[ language messages en_US.UTF-8 ]])

-- ime
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

-- Don't auto commenting new lines
autocmd("FileType", {
	pattern = "*",
	command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})

-- transparent with picom (take long time)
vim.cmd([[
  if system('pgrep -x picom > /dev/null && echo 1 || echo 0') == 1
    highlight Normal guibg=NONE
  " else
  "   highlight Normal guibg=#282A36
  endif
]])

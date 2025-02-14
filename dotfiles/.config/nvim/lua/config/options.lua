-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = "utf-8,sjis"
opt.swapfile = false
opt.gdefault = true
opt.number = false
opt.relativenumber = false

vim.g.snacks_animate = false -- disable animations

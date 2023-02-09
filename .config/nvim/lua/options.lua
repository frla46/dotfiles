-- options
vim.cmd [[ language messages en_US.UTF-8 ]]

vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.cursorline = true
vim.opt.encoding = "utf-8"
vim.opt.expandtab = true
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8", "sjis"
vim.opt.gdefault = true
vim.opt.helplang = "ja,en"
vim.opt.hidden = true
vim.opt.history = 1000
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.langmenu = "none"
vim.opt.laststatus = 2
vim.opt.matchpairs:append({"<:>"})
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append({ I = true })
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.statusline = "%F%m%=%l/%L"
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.virtualedit = "block"

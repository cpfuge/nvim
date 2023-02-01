-- editor configuration
vim.opt.mouse = 'a'
vim.opt.mousefocus = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.showmode = false
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.linebreak = true
vim.opt.termguicolors = true
vim.opt.shortmess:append("c")

-- indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true

-- colorscheme
vim.cmd([[ colorscheme slate ]])

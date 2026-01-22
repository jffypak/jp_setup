-- Options ported from LunarVim config

-- Leader key (must be set before lazy.nvim loads)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Python host
vim.g.python3_host_prog = "/Users/arizeuser/miniconda3/envs/py310/bin/python"

-- General options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

-- Disable format on save (matching LunarVim config)
vim.g.autoformat = false

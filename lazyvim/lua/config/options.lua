-- Options ported from LunarVim config

-- Python host
vim.g.python3_host_prog = "/Users/arizeuser/miniconda3/envs/py310/bin/python"

-- General options
vim.opt.number = true
vim.opt.relativenumber = false

-- Ensure relativenumber stays off after all plugins load
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.opt.relativenumber = false
  end,
})
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

-- Disable format on save (matching LunarVim config)
vim.g.autoformat = false

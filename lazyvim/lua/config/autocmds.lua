-- Autocmds ported from LunarVim config

-- Python specific settings (2-space indentation)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
    vim.opt_local.indentexpr = ""
    vim.opt_local.autoindent = true
    vim.opt_local.smartindent = false
  end,
})

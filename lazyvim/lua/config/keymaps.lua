-- Keymaps ported from LunarVim config

local map = vim.keymap.set

-- Save with Ctrl+S
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

-- Buffer navigation (matching LunarVim)
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })

-- LSP keymaps (will be set up on LspAttach)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    map("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", vim.tbl_extend("force", opts, { desc = "Find References" }))
    map("n", "<leader>lR", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
    map("n", "<leader>lf", function()
      require("conform").format({ async = false, lsp_fallback = true })
    end, vim.tbl_extend("force", opts, { desc = "Format" }))
  end,
})

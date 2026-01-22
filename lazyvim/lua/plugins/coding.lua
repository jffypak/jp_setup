-- Coding plugins ported from LunarVim config
return {
  -- Conform.nvim for formatting (matching LunarVim config)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
      },
      format_on_save = false,
    },
  },

  -- Treesitter with specific parsers (matching LunarVim)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "javascript",
        "json",
        "lua",
        "python",
        "typescript",
        "tsx",
        "css",
        "rust",
        "java",
        "yaml",
        "go",
        -- Additional parsers LazyVim expects
        "html",
        "markdown",
        "markdown_inline",
        "regex",
        "vim",
        "vimdoc",
      },
      highlight = {
        enable = true,
      },
    },
  },
}

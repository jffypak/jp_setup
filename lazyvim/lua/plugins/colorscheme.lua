-- Colorscheme configuration
return {
  -- Configure tokyonight (already included in LazyVim)
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm",
    },
  },
  -- Set tokyonight as the default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  -- Additional themes
  { "datsfilipe/min-theme.nvim" },
  {
    "embark-theme/vim",
    lazy = false,
    priority = 1000,
    name = "embark",
  },
}

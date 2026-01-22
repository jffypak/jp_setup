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
  -- Additional theme from your LunarVim config
  { "datsfilipe/min-theme.nvim" },
}

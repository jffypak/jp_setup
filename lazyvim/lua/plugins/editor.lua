-- Editor plugins ported from LunarVim config
return {
  -- Vim Surround
  { "tpope/vim-surround" },

  -- Vim Abolish for smart search/replace/coercion
  { "tpope/vim-abolish" },

  -- Vim Sneak for quick motion
  { "justinmk/vim-sneak" },

  -- DelimitMate for auto-closing brackets
  { "Raimondi/delimitMate" },

  -- Open GitHub lines in browser
  { "ruanyl/vim-gh-line" },

  -- Configure nvim-tree (matching LunarVim settings)
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        position = "left",
      },
      default_component_configs = {
        git_status = {
          symbols = {
            -- Disable git icons (matching: nvimtree.setup.renderer.icons.show.git = false)
            added = "",
            modified = "",
            deleted = "",
            renamed = "",
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
      },
    },
  },

  -- Gitsigns with inline blame (matching LunarVim)
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 100,
      },
    },
  },
}

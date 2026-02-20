-- LSP configuration
return {
  -- Disable pyright
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = { enabled = false },
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                -- Disable plugins that overlap with ruff
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                mccabe = { enabled = false },
                pylsp_mypy = { enabled = false },
                pylsp_black = { enabled = false },
                pylsp_isort = { enabled = false },
                -- Keep useful plugins
                jedi_completion = { enabled = true },
                jedi_hover = { enabled = true },
                jedi_references = { enabled = true },
                jedi_signature_help = { enabled = true },
                jedi_symbols = { enabled = true },
              },
            },
          },
        },
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
        },
      },
    },
  },

  -- Ensure mason installs pylsp and ruff
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "python-lsp-server",
        "ruff",
      },
    },
  },
}

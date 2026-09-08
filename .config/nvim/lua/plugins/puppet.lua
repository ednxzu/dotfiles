return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "puppet" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        puppet = {},
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "puppet-editor-services" },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        puppet = { "puppet-lint" },
      },
    },
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim", "Snacks" },
              },
            },
          },
        },
        jinja_lsp = {
          filetypes = { "jinja", "jinja2", "htmljinja" },
        },
        tofu_ls = {
          mason = false,
          cmd = { "tofu-ls", "serve" },
          filetypes = { "terraform", "terraform-vars" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(".terraform", ".git")(fname)
          end,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "terraform", "hcl" },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
      },
      formatters = {
        terraform_fmt = { command = "tofu" },
      },
    },
  },
}

return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        sources = {
          files = { hidden = true },
          grep = { hidden = true },
          explorer = { hidden = true },
        },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
        },
      },
    },
  },
}

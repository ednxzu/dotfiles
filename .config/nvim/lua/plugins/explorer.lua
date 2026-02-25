return {
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        sources = {
          files = { hidden = true },
          grep = { hidden = true },
          explorer = {
            hidden = true,
            ignored = true,
            layout = {
              layout = {
                backdrop = false,
                width = 40,
                min_width = 40,
                height = 0,
                position = "left",
                border = "none",
                box = "vertical",
                { win = "list", border = "none" },
                { win = "preview", title = "{preview}", height = 0.4, border = "top" },
              },
            },
            win = {
              list = {
                keys = {
                  ["<Esc>"] = false,
                },
              },
            },
          },
        },
      },
      explorer = {
        replace_netrw = true,
      },
    },
  },
}

return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      word_diff = false,
      show_deleted = false,
    },
    keys = {
      {
        "<leader>gI",
        function()
          local gs = require("gitsigns")
          -- Toggle both inline deleted lines and word-level diff
          gs.toggle_word_diff()
          gs.toggle_deleted()
        end,
        desc = "Toggle inline Git diff",
      },
    },
  },
}

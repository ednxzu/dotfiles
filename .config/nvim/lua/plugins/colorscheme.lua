return {
  { "catppuccin", enabled = false },
  { "tokyonight.nvim", enabled = false },
  {
    "Mofiqul/dracula.nvim",
    opts = {
      overrides = function(colors)
        local bg = { 0x28, 0x2a, 0x36 }
        local function blend(hex, alpha)
          local r = math.floor(tonumber(hex:sub(2, 3), 16) * alpha + bg[1] * (1 - alpha))
          local g = math.floor(tonumber(hex:sub(4, 5), 16) * alpha + bg[2] * (1 - alpha))
          local b = math.floor(tonumber(hex:sub(6, 7), 16) * alpha + bg[3] * (1 - alpha))
          return string.format("#%02x%02x%02x", r, g, b)
        end
        return {
          DiffAdd = { bg = blend(colors.green, 0.3) },
          DiffChange = { bg = "NONE" },
          DiffDelete = { bg = blend(colors.red, 0.3) },
          DiffText = { bg = blend(colors.cyan, 0.3) },
          WinSeparator = { fg = "#bd93f9" },
          CursorLine = { bg = "#2c2e3b" },
          Whitespace = { fg = "#ff5555" },
          NeoTreeNormal = { bg = "NONE" },
          NeoTreeNormalNC = { bg = "NONE" },
          NeoTreeEndOfBuffer = { bg = "NONE" },
          NeoTreeCursorLine = { bg = colors.selection },
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}

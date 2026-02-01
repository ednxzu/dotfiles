-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "Toggle Explorer" })

-- Make :q, :bd, :x, :wq close the buffer instead of the window
vim.api.nvim_create_user_command("Bd", function()
  Snacks.bufdelete()
end, { desc = "Smart buffer delete" })

vim.cmd([[cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline() == "q" ? "Bd" : "q"]])
vim.cmd([[cnoreabbrev <expr> bd getcmdtype() == ":" && getcmdline() == "bd" ? "Bd" : "bd"]])
vim.cmd([[cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == "x" ? "w\|Bd" : "x"]])
vim.cmd([[cnoreabbrev <expr> wq getcmdtype() == ":" && getcmdline() == "wq" ? "w\|Bd" : "wq"]])

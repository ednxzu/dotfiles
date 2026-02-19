-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "Toggle Explorer" })

-- Make :q, :bd, :x, :wq close the buffer instead of the window
-- Only when multiple buffers are open; otherwise fall back to normal behavior
-- so that git integration and single-file editing work as expected
vim.api.nvim_create_user_command("Bd", function(opts)
  local listed_bufs = vim.fn.getbufinfo({ buflisted = 1 })
  local non_floating_wins = 0
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == "" then
      non_floating_wins = non_floating_wins + 1
    end
  end
  if #listed_bufs > 1 or non_floating_wins > 1 then
    Snacks.bufdelete()
  else
    vim.cmd(opts.bang and "q!" or "q")
  end
end, { bang = true, desc = "Smart buffer delete" })

vim.cmd([[cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline() == "q" ? "Bd" : "q"]])
vim.cmd([[cnoreabbrev <expr> bd getcmdtype() == ":" && getcmdline() == "bd" ? "Bd" : "bd"]])
vim.cmd([[cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == "x" ? "w\|Bd" : "x"]])
vim.cmd([[cnoreabbrev <expr> wq getcmdtype() == ":" && getcmdline() == "wq" ? "w\|Bd" : "wq"]])

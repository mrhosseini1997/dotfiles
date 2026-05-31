-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>'", function()
  vim.cmd("botright 15split | terminal")
  vim.cmd("startinsert")
end, { desc = "Shell (horizontal split)" })

vim.keymap.set("n", '<leader>"', function()
  vim.cmd("vertical rightbelow split | terminal")
  vim.cmd("startinsert")
end, { desc = "Shell (vertical split)" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Terminal: exit to normal mode" })

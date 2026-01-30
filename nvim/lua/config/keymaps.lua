local map = vim.keymap.set

map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit Vim" })
map("n", "<leader>a", ":keepjumps normal! ggVG<cr>")

-- Yank to clipboard
map("v", "Y", '"+y')

-- Select Whole File
map("v", "<leader>a", "ggVG", { desc = "Select all" })

-- Alt+Backspace deletes one word backwards in insert mode
map("i", "<A-BS>", "<C-w>", { noremap = true, silent = true })

-- Use <C-j> and <C-k> to navigate completion menu when it's visible
-- Falls back to normal <C-j>/<C-k> behavior when menu is not visible
map("i", "<C-j>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-j>"
end, { expr = true, noremap = true })

map("i", "<C-k>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-k>"
end, { expr = true, noremap = true })

-- Resize windows using Alt + h/j/k/l
local opts = { noremap = true, silent = true }
map("n", "<A-h>", "<cmd>vertical resize -2<CR>", opts) -- shrink horizontally
map("n", "<A-l>", "<cmd>vertical resize +2<CR>", opts) -- expand horizontally
map("n", "<A-j>", "<cmd>resize -2<CR>", opts)          -- shrink vertically
map("n", "<A-k>", "<cmd>resize +2<CR>", opts)          -- expand vertically
map("n", "<A-=>", "<C-w>=", opts)                      -- equalize window sizes

-- Use <Enter> to confirm item in popup instead of <C-y>
map("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-y>"
  else
    return "<CR>"
  end
end, { expr = true, noremap = true, silent = true })

require("config.terminal")


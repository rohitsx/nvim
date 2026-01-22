-- =====================
-- Core Neovim Settings
-- =====================

-- Disable netrw (avoid conflicts with file explorers like nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Tab & indentation
vim.opt.tabstop = 2      -- Number of spaces a <Tab> counts for
vim.opt.shiftwidth = 2   -- Number of spaces used for each step of (auto)indent
vim.opt.expandtab = true -- Convert tabs to spaces

-- UI
vim.opt.number = true -- Absolute line number for current line

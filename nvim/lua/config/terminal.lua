local term_buf = nil
local term_win = nil
local term_height = 15
local original_laststatus = vim.o.laststatus
local map = vim.keymap.set

local function toggle_terminal()
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) and vim.api.nvim_buf_is_loaded(term_buf) then
    if term_win and vim.api.nvim_win_is_valid(term_win) then
      term_height = vim.api.nvim_win_get_height(term_win)
      vim.api.nvim_win_hide(term_win)
      vim.o.laststatus = original_laststatus
    else
      -- Show terminal
      vim.cmd("botright " .. term_height .. "split")
      term_win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(term_win, term_buf)
      vim.o.laststatus = 0
      vim.cmd("startinsert")
    end
  else
    vim.cmd("botright " .. term_height .. "split | terminal")
    term_buf = vim.api.nvim_get_current_buf()
    term_win = vim.api.nvim_get_current_win()
    vim.o.laststatus = 0
    vim.cmd("startinsert")
  end
end

-- Normal mode mapping
map("n", "<C-`>", toggle_terminal, { noremap = true, silent = true, desc = "Toggle terminal" })

-- Insert mode mapping
map("i", "<C-`>", toggle_terminal, { noremap = true, silent = true, desc = "Toggle terminal" })

-- Terminal mode mapping (optional - allows toggling from within the terminal)
map("t", "<C-`>", toggle_terminal, { noremap = true, silent = true, desc = "Toggle terminal" })


-- In terminal mode, make <Esc> go to Normal mode
map("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

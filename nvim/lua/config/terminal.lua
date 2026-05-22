local term_buf = nil
local term_win = nil
local term_tab = nil
local term_height = math.floor(vim.o.lines * 0.5)
local original_laststatus = vim.o.laststatus
local map = vim.keymap.set
local term_name = "Terminal"

local function ensure_terminal_buf()
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) and vim.api.nvim_buf_is_loaded(term_buf) then
    return term_buf
  end

  vim.cmd("terminal")
  term_buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(term_buf, term_name)
  return term_buf
end

local function toggle_split_terminal()
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) and vim.api.nvim_buf_is_loaded(term_buf) then
    if term_win and vim.api.nvim_win_is_valid(term_win) then
      term_height = vim.api.nvim_win_get_height(term_win)
      vim.api.nvim_win_hide(term_win)
      vim.o.laststatus = original_laststatus
    else
      vim.cmd("botright " .. term_height .. "split")
      term_win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(term_win, term_buf)
      vim.o.laststatus = 0
    end
    return
  end

  vim.cmd("botright " .. term_height .. "split")
  term_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(term_win, ensure_terminal_buf())
  vim.o.laststatus = 0
end

local function toggle_tab_terminal()
  if term_tab and vim.api.nvim_tabpage_is_valid(term_tab) then
    if vim.api.nvim_get_current_tabpage() == term_tab then
      vim.cmd("tabclose")
      vim.o.laststatus = original_laststatus
    else
      vim.api.nvim_set_current_tabpage(term_tab)
    end
    return
  end

  vim.cmd("tabnew")
  term_tab = vim.api.nvim_get_current_tabpage()
  vim.api.nvim_win_set_buf(0, ensure_terminal_buf())
  vim.o.laststatus = 0
end

map("n", "<leader>`", toggle_tab_terminal, {
  noremap = true,
  silent = true,
  desc = "Toggle terminal tab",
})

map("n", "<A-`>", toggle_split_terminal, {
  noremap = true,
  silent = true,
  desc = "Toggle terminal",
})

-- In terminal mode, make <Esc> go to Normal mode
map("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

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


map("n", "<leader><leader>", "<C-^>", { desc = "Switch to last file" })

local function lsp_implementations_telescope()
  local bufnr = vim.api.nvim_get_current_buf()
  local winnr = vim.api.nvim_get_current_win()
  local clients = vim.lsp.get_clients({
    bufnr = bufnr,
    method = "textDocument/implementation",
  })

  if vim.tbl_isempty(clients) then
    vim.notify("No LSP client supports implementations for this buffer", vim.log.levels.WARN)
    return
  end

  local pending = #clients
  local locations = {}

  local function finish()
    if vim.tbl_isempty(locations) then
      vim.notify("No implementations found", vim.log.levels.INFO)
      return
    end

    if #locations == 1 then
      vim.lsp.util.jump_to_location(locations[1].location, locations[1].offset_encoding)
      return
    end

    local telescope = require("telescope")
    local conf = require("telescope.config").values
    local finders = require("telescope.finders")
    local make_entry = require("telescope.make_entry")
    local pickers = require("telescope.pickers")

    local items = {}
    for _, entry in ipairs(locations) do
      vim.list_extend(items, vim.lsp.util.locations_to_items({ entry.location }, entry.offset_encoding))
    end

    pickers
      .new(telescope.themes.get_dropdown({}), {
        prompt_title = "LSP Implementations",
        finder = finders.new_table({
          results = items,
          entry_maker = make_entry.gen_from_quickfix({}),
        }),
        previewer = conf.qflist_previewer({}),
        sorter = conf.generic_sorter({}),
        push_cursor_on_edit = true,
        push_tagstack_on_edit = true,
      })
      :find()
  end

  for _, client in ipairs(clients) do
    local params = vim.lsp.util.make_position_params(winnr, client.offset_encoding)

    client:request("textDocument/implementation", params, function(err, result)
      if err then
        vim.schedule(function()
          vim.notify(
            string.format("LSP implementation request failed for %s: %s", client.name, err.message),
            vim.log.levels.ERROR
          )
        end)
      elseif result then
        if not vim.tbl_islist(result) then
          result = { result }
        end

        for _, location in ipairs(result) do
          table.insert(locations, {
            location = location,
            offset_encoding = client.offset_encoding,
          })
        end
      end

      pending = pending - 1
      if pending == 0 then
        vim.schedule(finish)
      end
    end, bufnr)
  end
end

-- Go to implementation (LSP)
map("n", "gi", function()
  lsp_implementations_telescope()
end, { desc = "Go to implementation" })



map("n", "]e", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end)

map("n", "[e", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)

-- Close fold under cursor (current array/block)
vim.keymap.set("n", "zc", "zc")

-- Open fold under cursor
vim.keymap.set("n", "zo", "zo")

-- Toggle fold under cursor
vim.keymap.set("n", "za", "za")

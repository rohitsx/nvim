return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },

  config = function()
    require('telescope').setup {
      defaults = { file_ignore_patterns = { "node_modules", ".next", ".sevelte", "pnpm-lock.yml", ".git" } },
      pickers = {
        find_files = {
          hidden = true,
          theme = "ivy",
          previewer = false

        }
      },
      extensions = {
        fzf = {}
      }
    }

    require('telescope').load_extension('fzf')

    vim.keymap.set("n", "<leader>fh", require('telescope.builtin').help_tags)
    vim.keymap.set("n", "<leader>fg", require('telescope.builtin').live_grep)
    vim.keymap.set("n", "<leader>p", require('telescope.builtin').find_files)
    vim.keymap.set("n", "<leader>fv", function()
      require('telescope.builtin').find_files {
        cwd = vim.fn.stdpath("config") }
    end)
    vim.keymap.set("n", "<leader>fx", function()
      require('telescope.builtin').find_files {
        cwd = "/home/rohit/x",
        find_command = { "fd", "--type", "d", "--max-depth", "1" }
      }
    end)
  end
}

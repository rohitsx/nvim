return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },

  config = function()
    local builtin = require('telescope.builtin')
    
    require("telescope").setup({
      defaults = {
        -- vimgrep_arguments defines how 'live_grep' and 'grep_string' behave
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/*",
          "--glob=!node_modules/*",
          "--glob=!.next/*",
          "--glob=!.cache/*",
        },
        file_ignore_patterns = {
          "node_modules/",
          "%.git/",
          "%.next/",
          "%.cache/",
          "%.svelte/",
          "android",
          ".expo",
          ".wrangler"
        },
      },

      pickers = {
        find_files = {
          theme = "ivy",
          previewer = false,
          -- This defines how 'find_files' behaves (separate from live_grep)
          find_command = {
            "fd",
            "--type", "f",
            "--hidden",
            "--exclude", ".git",
            "--exclude", "node_modules",
            "--exclude", ".next",
            "--exclude", ".cache",
            "--exclude", "dist",
            "--strip-cwd-prefix",
          },
        },
      },

      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    -- Load extension
    require('telescope').load_extension('fzf')

    --- Keymaps ---
    vim.keymap.set("n", "<leader>fh", builtin.help_tags)
    vim.keymap.set("n", "<leader>fg", builtin.live_grep)
    vim.keymap.set("n", "<leader>p", builtin.find_files)
    
    -- Edit Config files
    vim.keymap.set("n", "<leader>fv", function()
      builtin.find_files {
        cwd = vim.fn.stdpath("config")
      }
    end)

    -- Custom Directory search (searching for directories only)
    vim.keymap.set("n", "<leader>fx", function()
      builtin.find_files {
        cwd = "/home/rohit/x",
        find_command = { "fd", "--type", "d", "--max-depth", "1" }
      }
    end)
  end
}

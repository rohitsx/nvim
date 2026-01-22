-- This page contain list of basic nvim plugin that are good for better ui and expreince they don't directly do anything aside from making nvim more fun and beatulifuu

return {
  -- Tracks your coding activity and syncs with your WakaTime dashboard
  { "wakatime/vim-wakatime" },
  {
    -- A statusline plugin written in Lua with rich customization
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Adds icons to the statusline
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "gruvbox", -- Sets the lualine theme
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = false,
          refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      fast_wrap = {},
    },
    config = function(_, opts)
      local autopairs = require("nvim-autopairs")
      autopairs.setup(opts)
      -- Safely integrate with nvim-cmp
      local ok, cmp = pcall(require, "cmp")
      if ok then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      local hooks = require "ibl.hooks"

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IndentGuide", { fg = "#4a4a4a" })
        vim.api.nvim_set_hl(0, "IblScope", { fg = "#7a7a7a" })
      end)

      hooks.register(
        hooks.type.SCOPE_HIGHLIGHT,
        hooks.builtin.scope_highlight_from_extmark
      )

      require("ibl").setup {
        indent = {
          char = "│",
          highlight = { "IndentGuide" },
        },
        scope = {
          enabled = true,
          show_start = true,
          highlight = { "IblScope" },
          show_end = true,
        },
      }
    end,
  }
}

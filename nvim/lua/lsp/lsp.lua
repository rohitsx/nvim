return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      -- lspconfig.denols.setup {}
      lspconfig.ts_ls.setup({
        root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json"),
        settings = {
          typescript = {
            tsserver = {
              maxTsServerMemory = 4096, -- Give TS more memory (works wonders)
            },
          },
          javascript = {
            tsserver = {
              maxTsServerMemory = 4096,
            },
          },
        },

        -- init_options = {
        --   preferences = {
        --     disableSuggestions = true, -- Speed up completions
        --   },
        -- },

        on_attach = function(client)
          -- Disable semantic tokens (HUGE performance boost)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      })
      lspconfig.lua_ls.setup {}
      lspconfig.pyright.setup {}
      lspconfig.stylelint_lsp.setup {}
      lspconfig.svelte.setup {}
      lspconfig.bashls.setup {}
      lspconfig.cssls.setup {}
      lspconfig.jsonls.setup {}
      lspconfig.stylelint_lsp.setup {}
      lspconfig.tailwindcss.setup {
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "tw`([^`]*)",    ".*" }, -- tw`...`
                { "tw%(([^)]*)%)", ".*" }, -- tw("...")
              },
            },
          },
        },
      }

      -- Format current buffer with LSP
      -- vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)

      -- Enable virtual text for diagnostics (inline error/warning messages)
      vim.diagnostic.config({ virtual_text = true })
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })

      -- Completion settings to prevent auto-selecting the first item
      -- vim.opt.completeopt = { "menu", "menuone", "noselect" }
      --
      -- -- Auto command for when LSP attaches to a buffer
      -- vim.api.nvim_create_autocmd('LspAttach', {
      --   callback = function(args)
      --     -- Enable auto-completion if supported
      --     local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      --     if client:supports_method('textDocument/completion') then
      --       -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      --       local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      --       client.server_capabilities.completionProvider.triggerCharacters = chars
      --
      --       -- Enable LSP completion with autotrigger
      --       vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      --     end
      --   end,
      -- })
    end,
  },

  -- {
  --   "stevearc/conform.nvim",
  --   opts = {
  --     formatters_by_ft = {
  --       lua = { "stylua" },
  --       javascript = { "prettier" },
  --       typescript = { "prettier" },
  --       svelte = { "prettier" },
  --       css = { "prettier" },
  --       html = { "prettier" },
  --       python = { "black" },
  --       sh = { "shfmt" },
  --     },
  --   },
  --   config = function(_, opts)
  --     local conform = require("conform")
  --     conform.setup(opts)
  --
  --     -- Override <leader>f to use conform with LSP fallback
  --     vim.keymap.set("n", "<leader>f", function()
  --       conform.format({ async = true, lsp_fallback = true })
  --     end, { desc = "Format file" })
  --   end,
  -- },
  --
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load() -- Load snippets lazily
    end,
  },

  -- nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        -- Snippet expansion
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        -- Minimal completion settings for speed
        completion = {
          completeopt = "menu,menuone,noselect",
          keyword_length = 1, -- Trigger completion after 1 character
        },
        -- Minimal mappings for speed
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item(),        -- Navigate down
          ["<C-k>"] = cmp.mapping.select_prev_item(),        -- Navigate up
          ["<C-Space>"] = cmp.mapping.complete(),            -- Trigger completion
          ["<C-e>"] = cmp.mapping.abort(),                   -- Close completion menu
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
        }),
        -- Minimal sources for speed
        sources = {
          { name = "nvim_lsp", max_item_count = 10 }, -- Limit LSP suggestions
          { name = "luasnip",  max_item_count = 5 },  -- Limit snippet suggestions
        },
        -- Disable heavy formatting for speed
        formatting = {
          fields = { "abbr", "kind" }, -- Show only abbreviation and kind
          format = function(_, vim_item)
            vim_item.menu = nil        -- Remove menu to reduce clutter
            return vim_item
          end,
        },
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typescript = { "prettier" },
        javascript = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
      },
    },
    config = function(_, opts)
      local conform = require("conform")
      conform.setup(opts)
      vim.keymap.set("n", "<leader>f", function()
        conform.format({ async = true, lsp_fallback = true })
      end, { desc = "Format file" })
    end,
  }

}

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
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
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

        if client.name == "ts_ls" then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end

      -- TypeScript / JavaScript
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          typescript = { tsserver = { maxTsServerMemory = 4096 } },
          javascript = { tsserver = { maxTsServerMemory = 4096 } },
        },
      })

      -- Simple servers
      local servers = {
        "lua_ls",
        "pyright",
        "stylelint_lsp",
        "svelte",
        "bashls",
        "cssls",
        "jsonls",
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end

      -- TailwindCSS with custom regex
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "tw`([^`]*)", ".*" },
                { "tw%(([^)]*)%)", ".*" },
              },
            },
          },
        },
      })

      -- Diagnostics & keymaps
      vim.diagnostic.config({ virtual_text = true })
      vim.keymap.set(
        "n",
        "<leader>d",
        vim.diagnostic.open_float,
        { desc = "Show diagnostics" }
      )
    end,
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- Completion
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
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noselect",
          keyword_length = 1,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp", max_item_count = 10 },
          { name = "luasnip", max_item_count = 5 },
        },
        formatting = {
          fields = { "abbr", "kind" },
          format = function(_, item)
            item.menu = nil
            return item
          end,
        },
      })
    end,
  },

  -- Formatting
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
  },
}
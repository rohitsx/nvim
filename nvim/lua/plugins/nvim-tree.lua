return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		vim.opt.termguicolors = true
		vim.keymap.set("n", "<leader>e", function()
			require("nvim-tree.api").tree.toggle({ focus = true })
		end, { desc = "Toggle NvimTree" })

		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			vim.keymap.set("n", "l", api.node.open.edit, opts("Open File"))
		end

		require("nvim-tree").setup({
			on_attach = my_on_attach,
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 30,
			},
			filters = {
				dotfiles = false,
			},
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
			renderer = {
				group_empty = true,
				highlight_git = true, -- highlight git status
				highlight_modified = "all",
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
					glyphs = {
						modified = "",
						git = {
							unstaged = "|",
							staged = "",
							unmerged = "",
							renamed = "",
							deleted = "",
							untracked = "",
							ignored = "",
						},
					},
				},
			},
			modified = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
			},
			git = {
				enable = true,
				ignore = false,
				show_on_dirs = true,
				show_on_open_dirs = true,
			},
		})
	end,
}

return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "nord",
		},
	},
	{ "shaunsingh/nord.nvim" },
	{ "vim-jp/vimdoc-ja" },
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
	},
	{
		"lmburns/lf.nvim",
		dependencies = { "plenary.nvim", "toggleterm.nvim" },
		keys = {
			{ "<leader>e", "<cmd>Lf<cr>" },
		},
		opts = function()
			-- vim.g.lf_netrw = 1
			require("lf").setup({
				-- escape_quit = true,
				border = "rounded",
			})
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		lazy = true,
	},
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader><esc>",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Delete all Notifications",
			},
		},
		opts = {
			stages = "static",
			background_colour = "#000000", -- for transparent
			--fps = 60,
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		init = function()
			local Util = require("lazyvim.util")
			if not Util.has("noice.nvim") then
				Util.on_very_lazy(function()
					vim.notify = require("notify")
				end)
			end
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			local icons = require("lazyvim.config").icons

			local function fg(name)
				return function()
					---@type {foreground?:number}?
					local hl = vim.api.nvim_get_hl_by_name(name, true)
					return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
				end
			end

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            -- stylua: ignore
            {
              function() return require("nvim-navic").get_location() end,
              cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            },
					},
					lualine_x = {
						{
							function()
								return require("noice").api.status.command.get()
							end,
							cond = function()
								return package.loaded["noice"] and require("noice").api.status.command.has()
							end,
							color = fg("Statement"),
						},
						{
							function()
								return require("noice").api.status.mode.get()
							end,
							cond = function()
								return package.loaded["noice"] and require("noice").api.status.mode.has()
							end,
							color = fg("Constant"),
						},
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = fg("Special"),
						},
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
						},
					},
					lualine_y = {},
					lualine_z = {
						{ "location", padding = { left = 0, right = 1 } },
					},
				},
			}
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
		opts = {
			defaults = {
				mappings = {
					i = {
						["<Esc>"] = function(...)
							return require("telescope.actions").close(...)
						end,
						["<C-j>"] = function(...)
							return require("telescope.actions").move_selection_next(...)
						end,
						["<C-k>"] = function(...)
							return require("telescope.actions").move_selection_previous(...)
						end,
					},
				},
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
			},
			pickers = {
				find_files = { hidden = true },
			},
		},
	},
	{
		"nvim-orgmode/orgmode",
		event = { "VeryLazy" },
		ft = { "org" },
		opts = function()
			require("orgmode").setup_ts_grammar()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "org" },
				},
				ensure_installed = { "org" },
			})
			require("orgmode").setup({
				org_agenda_files = { "~/doc/org/*" },
				org_default_notes_file = "~/doc/org/refile.org",
			})
		end,
	},
}

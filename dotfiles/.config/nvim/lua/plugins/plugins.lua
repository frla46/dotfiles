return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "nord",
		},
	},
	{ "shaunsingh/nord.nvim" },
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
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
	},
	{
		"nvim-telescope/telescope.nvim",
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
		"L3MON4D3/LuaSnip",
		build = (not jit.os:find("Windows"))
				and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
			or nil,
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				-- require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_lua").load({ paths = "./lua/snip/luasnip/" })
			end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
	},
	{
		"is0n/jaq-nvim",
		keys = {
			{ "<leader>r", "<cmd>Jaq<cr>", desc = "Quickrun (jaq-nvim)" },
		},
		opts = function()
			require("jaq-nvim").setup({
				cmds = {
					internal = {},
					external = {
						python = "python %",
						cpp = "g++ % && ./a.out",
						tex = "docker run -u $(id -u):$(id -g) --rm -v ${PWD}:/workdir ghcr.io/being24/latex-docker latexmk ./main.tex",
					},
				},
				behavior = {
					-- Default type
					default = "quickfix",
					-- Start in insert mode
					startinsert = false,
					-- Use `wincmd p` on startup
					wincmd = false,
					-- Auto-save files
					autosave = false,
				},
				ui = {
					quickfix = {
						position = "bot",
						size = 10,
					},
				},
			})
		end,
	},
	{
		"mickael-menu/zk-nvim",
		keys = {
			{
				"<leader>zn",
				function()
					require("zk.commands").get("ZkNew")({})
				end,
				desc = "Create notes (zk)",
			},
			{
				"<leader>zf",
				function()
					require("zk.commands").get("ZkNotes")({ sort = { "modified" } })
				end,
				desc = "Open notes (zk)",
			},
			{
				"<leader>zt",
				function()
					require("zk.commands").get("ZkTags")({})
				end,
				desc = "Open notes (zk)",
			},
			{
				"<leader>zl",
				function()
					require("zk.commands").get("ZkLinks")()
				end,
				desc = "Open notes linked by the current note (zk)",
			},
			{
				"<leader>zb",
				function()
					require("zk.commands").get("ZkBacklinks")()
				end,
				desc = "Open notes linking to the current note (zk)",
			},
		},
		config = function()
			require("zk").setup({
				-- can be "telescope", "fzf" or "select" (`vim.ui.select`)
				-- it's recommended to use "telescope" or "fzf"
				picker = "telescope",
				lsp = {
					-- `config` is passed to `vim.lsp.start_client(config)`
					config = {
						cmd = { "zk", "lsp" },
						name = "zk",
						-- on_attach = ...
						-- etc, see `:h vim.lsp.start_client()`
					},
					-- automatically attach buffers in a zk notebook that match the given filetypes
					auto_attach = {
						enabled = true,
						filetypes = { "markdown" },
					},
				},
			})
		end,
	},
	-- -- disabled plugins
	{ "folke/tokyonight.nvim", enabled = false },
	{ "catppuccin", enabled = false },
	{ "echasnovski/mini.indentscope", enabled = false },
}

return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "nord",
		},
	},
	{
		"shaunsingh/nord.nvim",
		config = function()
			vim.g.nord_disable_background = true
			require("nord").set()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
			config = function()
				require("telescope").load_extension("undo")
			end,
		},
		keys = {
			{
				"<leader>su",
				"<cmd>Telescope undo<cr>",
				desc = "Undo tree",
			},
		},
		opts = {
			defaults = {
				-- mappings = {
				-- 	i = {
				-- 		["<Esc>"] = function(...)
				-- 			return require("telescope.actions").close(...)
				-- 		end,
				-- 		["<C-j>"] = function(...)
				-- 			return require("telescope.actions").move_selection_next(...)
				-- 		end,
				-- 		["<C-k>"] = function(...)
				-- 			return require("telescope.actions").move_selection_previous(...)
				-- 		end,
				-- 	},
				-- },
				-- layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
			},
			pickers = {
				find_files = { hidden = true },
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader><esc>",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Clear all Notifications",
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
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "v2.*",
		build = "make install_jsregexp",
		opts = function()
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/" } })
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
				desc = "Create note (zk)",
			},
			{
				"<leader>zf",
				function()
					require("zk.commands").get("ZkNotes")({ sort = { "modified" } })
				end,
				desc = "Find note (zk)",
			},
			{
				"<leader>zt",
				function()
					require("zk.commands").get("ZkTags")({})
				end,
				desc = "Find tag (zk)",
			},
			{
				"<leader>zl",
				function()
					require("zk.commands").get("ZkLinks")()
				end,
				desc = "Find notes linked by the current note (zk)",
			},
			{
				"<leader>zb",
				function()
					require("zk.commands").get("ZkBacklinks")()
				end,
				desc = "Find notes linking to the current note (zk)",
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
	-- {
	-- 	"pwntester/octo.nvim",
	-- 	event = "VeryLazy",
	-- 	requires = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	config = function()
	-- 		require("octo").setup()
	-- 	end,
	-- },
	-- Sample configuration is supplied
	{
		"lmburns/lf.nvim",
		dependencies = { "akinsho/toggleterm.nvim" },
		keys = {
			{
				"<leader>e",
				"<cmd>Lf<cr>",
				desc = "lf",
			},
		},
		config = function()
			vim.g.lf_netrw = 1
			require("lf").setup({
				escape_quit = false,
				border = "single",
			})
		end,
	},
	{
		"michaelb/sniprun",
		branch = "master",
		build = "sh install.sh",
		keys = {
			{
				"<leader>rr",
				"<cmd>SnipRun",
				desc = "Sniprun",
			},
			{
				"<leader>rR",
				"<cmd>SnipReset",
				desc = "SnipReset",
			},
			{
				"<leader>rc",
				"<cmd>SnipClose",
				desc = "SnipClose",
			},
		},
		config = function()
			require("sniprun").setup({
				-- your options
			})
		end,
	},
	-- -- disabled plugins
	{ "folke/tokyonight.nvim", enabled = false },
	{ "catppuccin", enabled = false },
	{ "echasnovski/mini.indentscope", enabled = false },
	{ "nvim-neo-tree/neo-tree.nvim", enabled = false },
}

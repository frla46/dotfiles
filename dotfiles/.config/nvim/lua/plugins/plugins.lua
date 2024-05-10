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
		},
		opts = {
			defaults = {
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
			},
			pickers = {
				find_files = {
					hidden = true,
				},
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
		"echasnovski/mini.splitjoin",
		keys = {
			{
				"gS",
				function()
					MiniSplitjoin.toggle()
				end,
				desc = "MiniSplitjoin",
			},
		},
		config = function()
			require("mini.splitjoin").setup({})
		end,
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		ft = "markdown",
		keys = {
			{
				"<leader>zn",
				"<cmd>ObsidianNew<cr>",
			},
			{
				"<leader>zt",
				"<cmd>ObsidianToday<cr>",
			},
			{
				"<leader>zT",
				"<cmd>ObsidianTags<cr>",
			},
			{
				"<leader>zf",
				"<cmd>ObsidianSearch<cr>",
			},
			{
				"<leader>zl",
				"<cmd>ObsidianFollowLink<cr>",
			},
			{
				"<leader>zb",
				"<cmd>ObsidianBacklinks<cr>",
			},
			{
				"<leader>zi",
				"<cmd>ObsidianPasteImg<cr>",
			},
			{
				"<leader>zw",
				"<cmd>ObsidianWorkspace<cr>",
			},
			{
				"<leader>zr",
				"<cmd>ObsidianRename<cr>",
			},
		},
		opts = {
			workspaces = {
				{
					name = "memo",
					path = "~/backup/memo",
				},
			},
			completion = { nvim_cmp = true },
			daily_notes = {
				folder = "daily",
				date_format = "%Y-%m-%d",
				alias_format = nil,
				template = "daily.md",
			},
			templates = {
				folder = "templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
			},
			follow_url_func = function(url)
				vim.fn.jobstart({ "xdg-open", url })
			end,
			ui = {
				enable = true,
				update_debounce = 200,
				checkboxes = {
					[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
					["x"] = { char = "", hl_group = "ObsidianDone" },
				},
			},
		},
	},
	-- -- disabled plugins
	{ "folke/tokyonight.nvim", enabled = false },
	{ "catppuccin", enabled = false },
	{ "echasnovski/mini.indentscope", enabled = false },
	{ "nvim-neo-tree/neo-tree.nvim", enabled = false },
}

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
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			opts.sections.lualine_z = opts.sections.lualine_y
			opts.sections.lualine_y = {}
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
				"<leader>zo",
				"<cmd>ObsidianOpen<cr>",
				desc = "ObsidianOpen",
			},
			{
				"<leader>zn",
				"<cmd>ObsidianNew<cr>",
				desc = "ObsidianNew",
			},
			{
				"<leader>zt",
				"<cmd>ObsidianToday<cr>",
				desc = "ObsidianToday",
			},
			{
				"<leader>zT",
				"<cmd>ObsidianTags<cr>",
				desc = "ObsidianTags",
			},
			{
				"<leader>zf",
				"<cmd>ObsidianSearch<cr>",
				desc = "ObsidianSearch",
			},
			{
				"<leader>zl",
				"<cmd>ObsidianFollowLink<cr>",
				desc = "ObsidianFollowLink",
			},
			{
				"<leader>zb",
				"<cmd>ObsidianBacklinks<cr>",
				desc = "ObsidianBacklinks",
			},
			{
				"<leader>zi",
				"<cmd>ObsidianPasteImg<cr>",
				desc = "ObsidianPasteImg",
			},
			{
				"<leader>zw",
				"<cmd>ObsidianWorkspace<cr>",
				desc = "ObsidianWorkspace",
			},
			{
				"<leader>zr",
				"<cmd>ObsidianRename<cr>",
				desc = "ObsidianRename",
			},
		},
		opts = {
			workspaces = {
				{
					name = "memo",
					path = "~/backup/memo",
				},
			},
			completion = { nvim_cmp = false },
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
				enable = false,
				update_debounce = 200,
				checkboxes = {
					[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
					["x"] = { char = "", hl_group = "ObsidianDone" },
				},
			},
		},
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			{ "saghen/blink.compat", lazy = true, version = false },
		},
		opts = {
			sources = {
				compat = { "obsidian", "obsidian_new", "obsidian_tags" },
			},
		},
	},
	-- -- disabled plugins
	{ "folke/tokyonight.nvim", enabled = false },
	{ "catppuccin", enabled = false },
	{ "nvim-neo-tree/neo-tree.nvim", enabled = false },
}

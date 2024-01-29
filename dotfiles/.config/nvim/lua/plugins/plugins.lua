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
				"<cmd>SnipRun<cr>",
				desc = "Sniprun",
				mode = { "n", "v" },
			},
			{
				"<leader>rR",
				"<cmd>SnipReset<cr>",
				desc = "SnipReset",
			},
			{
				"<leader>rc",
				"<cmd>SnipClose<cr>",
				desc = "SnipClose",
			},
		},
		config = function()
			require("sniprun").setup({})
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
		"monaqa/dial.nvim",
		keys = {
			{
				"+",
				function()
					require("dial.map").manipulate("increment", "normal")
				end,
				desc = "Add",
			},
			{
				"-",
				function()
					require("dial.map").manipulate("decrement", "normal")
				end,
				desc = "Subtract",
			},
			{
				"g+",
				function()
					require("dial.map").manipulate("increment", "gnormal")
				end,
				desc = "Add sequence",
			},
			{
				"g-",
				function()
					require("dial.map").manipulate("decrement", "gnormal")
				end,
				desc = "Subtract sequence",
			},
			{
				"+",
				function()
					require("dial.map").manipulate("increment", "visual")
				end,
				mode = { "v" },
				desc = "Add",
			},
			{
				"-",
				function()
					require("dial.map").manipulate("decrement", "visual")
				end,
				mode = { "v" },
				desc = "Subtract",
			},
			{
				"g+",
				function()
					require("dial.map").manipulate("increment", "gvisual")
				end,
				mode = { "v" },
				desc = "Add sequence",
			},
			{
				"g-",
				function()
					require("dial.map").manipulate("decrement", "gvisual")
				end,
				mode = { "v" },
				desc = "Subtract sequence",
			},
		},
	},
	{
		"renerocksai/telekasten.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{
				"<leader>z",
				function()
					require("telekasten").panel()
				end,
				desc = "Open panel (telekasten)",
			},
			{
				"<leader>zn",
				function()
					require("telekasten").new_note()
				end,
				desc = "Create new note (telekasten)",
			},
			{
				"<leader>zf",
				function()
					require("telekasten").find_notes()
				end,
				desc = "Find notes (telekasten)",
			},
			{
				"<leader>zg",
				function()
					require("telekasten").search_notes()
				end,
				desc = "Grep notes (telekasten)",
			},
			{
				"<leader>zt",
				function()
					require("telekasten").find_daily_notes()
				end,
				desc = "Find daily notes by title (telekasten)",
			},
			{
				"<leader>zl",
				function()
					require("telekasten").follow_link()
				end,
				desc = "Follow the link under the cursor (telekasten)",
			},
		},
		config = function()
			local zk_home = vim.fn.expand("~/backup/zettelkasten/")
			require("telekasten").setup({
				home = zk_home,
				dailies = zk_home .. "/" .. "daily",
				weeklies = zk_home .. "/" .. "weekly",
				templates = zk_home .. "/" .. "templates",
				template_new_note = zk_home .. "/" .. "templates/new_note.md",
				template_new_daily = zk_home .. "/" .. "templates/daily.md",
				template_new_weekly = zk_home .. "/" .. "templates/weekly.md",
			})
		end,
	},
	-- -- disabled plugins
	{ "folke/tokyonight.nvim", enabled = false },
	{ "catppuccin", enabled = false },
	{ "echasnovski/mini.indentscope", enabled = false },
	{ "nvim-neo-tree/neo-tree.nvim", enabled = false },
	-- { "headlines.nvim", enabled = false },
}

return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"saghen/blink.cmp",
		"folke/snacks.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	ft = "markdown",
	keys = {
		{ "<leader>zn", "<cmd>Obsidian new<cr>", desc = "Obsidian new" },
		{ "<leader>zf", "<cmd>Obsidian search<cr>", desc = "Obsidian search" },
		{ "<leader>zz", "<cmd>Obsidian today<cr>", desc = "Obsidian today" },
		{ "<leader>zk", "<cmd>Obsidian backlinks<cr>", desc = "Obsidian backlinks" },
		{ "<leader>zo", "<cmd>Obsidian open<cr>", desc = "Obsidian open" },
		{ "<leader>zT", "<cmd>Obsidian tags<cr>", desc = "Obsidian tags" },
		{ "<leader>zi", "<cmd>Obsidian paste_img<cr>", desc = "Obsidian paste img" },
	},
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "memo",
				path = "~/sync/memo",
			},
		},
		notes_subdir = "inbox",
		note = {
			template = "default.md",
		},
		daily_notes = {
			folder = "daily",
			date_format = "%Y-%m-%d",
			template = "daily.md",
		},
		templates = {
			folder = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
		},
		preferred_link_style = "markdown",
		attachments = {
			folder = "assets",
			---@return string
			img_name_func = function()
				return string.format("%s", os.date("%Y%m%d%H%M%S"))
			end,
		},
	},
}

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
		{ "<leader>zn", "<cmd>ObsidianNew<cr>", desc = "ObsidianNew" },
		{ "<leader>zf", "<cmd>ObsidianSearch<cr>", desc = "ObsidianSearch" },
		{ "<leader>zt", "<cmd>ObsidianToday<cr>", desc = "ObsidianToday" },
		{ "<leader>zj", "<cmd>ObsidianLinks<cr>", desc = "ObsidianLinks" },
		{ "<leader>zk", "<cmd>ObsidianBacklinks<cr>", desc = "ObsidianBacklinks" },
		{ "<leader>zo", "<cmd>ObsidianOpen<cr>", desc = "ObsidianOpen" },
		{ "<leader>zT", "<cmd>ObsidianTags<cr>", desc = "ObsidianTags" },
		{ "<leader>zi", "<cmd>ObsidianPasteImg<cr>", desc = "ObsidianPasteImg" },
	},
	opts = {
		workspaces = {
			{
				name = "memo",
				path = "~/sync/memo",
			},
		},
		notes_subdir = "inbox",
		picker = {
			name = "snacks.pick",
		},
		daily_notes = {
			folder = "daily",
			date_format = "%Y-%m-%d",
			alias_format = nil,
			template = "daily",
		},
		templates = {
			folder = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
		},
		preferred_link_style = "markdown",
		---@param url string
		follow_url_func = function(url)
			vim.fn.jobstart({ "zen-browser", url })
		end,
		attachments = {
			img_folder = "assets",
			---@return string
			img_name_func = function()
				return string.format("%s", os.date("%Y%m%d%H%M%S"))
			end,
		},
	},
}

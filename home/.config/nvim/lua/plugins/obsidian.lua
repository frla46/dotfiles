return {
	"obsidian-nvim/obsidian.nvim",
	-- version = "*",
	version = "3.14.3",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"saghen/blink.cmp",
		"folke/snacks.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	ft = "markdown",
	keys = {
		{ "<leader>zn", "<cmd>Obsidian new<cr>", desc = "Obsidian new" },
		-- { "<leader>zN", "<cmd>Obsidian new_from_template<cr>", desc = "Obsidian new from template" },
		{ "<leader>zf", "<cmd>Obsidian search<cr>", desc = "Obsidian search" },
		{ "<leader>zz", "<cmd>Obsidian today<cr>", desc = "Obsidian today" },
		-- { "<leader>zt", "<cmd>Obsidian template<cr>", desc = "Obsidian template" },
		-- { "<leader>zj", "<cmd>Obsidian links<cr>", desc = "Obsidian links" },
		{ "<leader>zk", "<cmd>Obsidian backlinks<cr>", desc = "Obsidian backlinks" },
		{ "<leader>zo", "<cmd>Obsidian open<cr>", desc = "Obsidian open" },
		{ "<leader>zT", "<cmd>Obsidian tags<cr>", desc = "Obsidian tags" },
		{ "<leader>zi", "<cmd>Obsidian paste_img<cr>", desc = "Obsidian paste img" },
	},
	opts = {
		workspaces = {
			{
				name = "memo",
				path = "~/sync/memo",
			},
		},
		notes_subdir = "inbox",
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

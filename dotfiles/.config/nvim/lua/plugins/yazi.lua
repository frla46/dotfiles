return {
	{
		"mikavilpas/yazi.nvim",
		dependencies = { "folke/snacks.nvim" },
		cond = function()
			return vim.fn.executable("yazi") == 1
		end,
		keys = {
			{
				"<leader>e",
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
		},
		opts = {
			open_for_directories = false,
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		cond = function()
			return vim.fn.executable("yazi") ~= 1
		end,
	},
}

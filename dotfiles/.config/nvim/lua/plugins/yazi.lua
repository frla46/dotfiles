return {
	"mikavilpas/yazi.nvim",
	dependencies = { "folke/snacks.nvim" },
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
}

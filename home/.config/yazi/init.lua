require("yatline"):setup({
	show_background = false,
	style_b = { bg = "reset", fg = "white" },
	style_c = { bg = "reset", fg = "cyan" },
	display_status_line = false,

	header_line = {
		left = {
			section_a = {},
			section_b = {},
			section_c = { { type = "string", custom = false, name = "hovered_path" } },
		},
		right = {
			section_a = {},
			section_b = { { type = "string", custom = false, name = "cursor_position" } },
			section_c = {},
		},
	},
})

require("simple-tag"):setup({
	ui_mode = "text",
	save_path = os.getenv("HOME") .. "/.local/share/yazi/tags",
})

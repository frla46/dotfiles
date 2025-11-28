require("yatline"):setup({
	show_background = false,
	display_status_line = false,
	style_a = {
		fg = "black",
		bg_mode = {
			normal = "blue",
		},
	},
	tab_width = 0,

	header_line = {
		left = {
			section_a = {
				{ type = "line", custom = false, name = "tabs", params = { "left" } },
			},
			section_b = {},
			section_c = {},
		},
		right = {
			section_a = {
				{ type = "string", custom = false, name = "cursor_position" },
			},
			section_b = {
				{ type = "string", custom = false, name = "hovered_ownership" },
				{ type = "string", custom = false, name = "hovered_size" },
				{ type = "coloreds", custom = false, name = "permissions" },
			},
			section_c = {
				{ type = "string", custom = false, name = "hovered_path" },
			},
		},
	},
})

require("simple-tag"):setup({
	ui_mode = "text",
	save_path = os.getenv("HOME") .. "/.local/share/yazi/tags",
})

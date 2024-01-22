local wezterm = require("wezterm")
local act = wezterm.action

return {
	font_size = 12.0,
	color_scheme = "nord",
	window_background_opacity = 0.8,
	use_ime = true,
	font = wezterm.font_with_fallback({
		{ family = "hackgen console", weight = "Regular" },
	}),
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = false,
	-- use_fancy_tab_bar = false,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	-- 	return {
	-- 		{ Text = " " .. tab.active_pane.title .. " " },
	-- 	}
	-- end),
	leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {
		{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "q", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },
		{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
		{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
		{ key = "w", mods = "LEADER", action = act.ShowTabNavigator },

		{ key = "|", mods = "LEADER | SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
		{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

		{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
		{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
		{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
		{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },

		{ key = "H", mods = "LEADER", action = act.AdjustPaneSize({ "Left", 5 }) },
		{ key = "L", mods = "LEADER", action = act.AdjustPaneSize({ "Right", 5 }) },
		{ key = "K", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 5 }) },
		{ key = "J", mods = "LEADER", action = act.AdjustPaneSize({ "Down", 5 }) },

		{ key = "<", mods = "LEADER | SHIFT", action = act.MoveTabRelative(-1) },
		{ key = ">", mods = "LEADER | SHIFT", action = act.MoveTabRelative(1) },

		{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
		{ key = "Enter", mods = "ALT", action = "DisableDefaultAssignment" },
		{
			-- rename tab
			key = ",",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
	},
}

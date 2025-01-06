local wezterm = require("wezterm")
local act = wezterm.action
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

resurrect.periodic_save({
	interval_seconds = 300,
	save_tabs = true,
	save_windows = true,
	save_workspaces = true,
})
resurrect.set_max_nlines(10000)

local function tab_title(tab)
	local title = tab.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the default title.
	return tab.tab_index + 1 .. ""
end

local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

local BLACK = "#2E3440"
local GRAY = "#3B4252"
local LIGHT_GRAY = "#434C5E"
local WHITE = "#D8DEE9"
local BLUE = "#81A1C1"

local TAB_BAR_BG = BLACK
local ACTIVE_TAB_BG = BLUE
local ACTIVE_TAB_FG = BLACK
local HOVER_TAB_BG = LIGHT_GRAY
local HOVER_TAB_FG = WHITE
local NORMAL_TAB_BG = GRAY
local NORMAL_TAB_FG = WHITE

wezterm.on("format-tab-title", function(tab, tabs, _, _, hover, _)
	local title = tab_title(tab)

	local background = NORMAL_TAB_BG
	local foreground = NORMAL_TAB_FG

	local is_first = tab.tab_id == tabs[1].tab_id
	local is_last = tab.tab_id == tabs[#tabs].tab_id

	if tab.is_active then
		background = ACTIVE_TAB_BG
		foreground = ACTIVE_TAB_FG
	elseif hover then
		background = HOVER_TAB_BG
		foreground = HOVER_TAB_FG
	end

	local leading_fg = NORMAL_TAB_BG
	local leading_bg = background

	local trailing_fg = background
	local trailing_bg = NORMAL_TAB_BG

	if is_first then
		leading_fg = TAB_BAR_BG
	end

	-- if tabs[1].is_active and is_first then
	-- 	leading_fg = ACTIVE_TAB_BG
	-- end

	if is_last then
		trailing_bg = TAB_BAR_BG
	end

	return {
		{ Background = { Color = leading_bg } },
		{ Foreground = { Color = leading_fg } },
		{ Text = SOLID_RIGHT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = " " .. title .. " " },
		{ Background = { Color = trailing_bg } },
		{ Foreground = { Color = trailing_fg } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

return {
	font_size = 12.0,
	color_scheme = "nord",
	window_background_opacity = 0.7,
	use_ime = true,
	-- disable_default_key_bindings = true,
	font = wezterm.font_with_fallback({
		{ family = "hackgen console", weight = "Regular" },
	}),
	hide_tab_bar_if_only_one_tab = true,
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	scrollback_lines = 100000,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
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
		{ key = "X", mods = "CTRL | SHIFT", action = act.ActivateCopyMode },
		{ key = "v", mods = "CTRL | SHIFT", action = act.PasteFrom("Clipboard") },
		{ key = "Enter", mods = "ALT", action = "DisableDefaultAssignment" },
		{
			-- rename tab
			key = ",",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, _, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		{
			-- Save current and window state
			-- See https://github.com/MLFlexer/resurrect.wezterm for options around
			-- saving workspace and window state separately
			key = "s",
			mods = "LEADER | CTRL",
			action = wezterm.action_callback(function(_, _)
				local state = resurrect.workspace_state.get_workspace_state()
				resurrect.save_state(state)
				resurrect.window_state.save_window_action()
			end),
		},
		{
			-- Load workspace or window state, using a fuzzy finder
			key = "l",
			mods = "LEADER | CTRL",
			action = wezterm.action_callback(function(win, pane)
				resurrect.fuzzy_load(win, pane, function(id, _)
					local type = string.match(id, "^([^/]+)") -- match before '/'
					id = string.match(id, "([^/]+)$") -- match after '/'
					id = string.match(id, "(.+)%..+$") -- remove file extension

					local opts = {
						window = win:mux_window(),
						relative = true,
						restore_text = true,
						on_pane_restore = resurrect.tab_state.default_on_pane_restore,
					}

					if type == "workspace" then
						local state = resurrect.load_state(id, "workspace")
						resurrect.workspace_state.restore_workspace(state, opts)
					elseif type == "window" then
						local state = resurrect.load_state(id, "window")
						-- opts.tab = win:active_tab()
						resurrect.window_state.restore_window(pane:window(), state, opts)
					elseif type == "tab" then
						local state = resurrect.load_state(id, "tab")
						resurrect.tab_state.restore_tab(pane:tab(), state, opts)
					end
				end)
			end),
		},
		{
			-- Delete a saved session using a fuzzy finder
			key = "d",
			mods = "LEADER | CTRL",
			action = wezterm.action_callback(function(win, pane)
				resurrect.fuzzy_load(win, pane, function(id)
					resurrect.delete_state(id)
				end, {
					title = "Delete State",
					description = "Select session to delete and press Enter = accept, Esc = cancel, / = filter",
					fuzzy_description = "Search session to delete: ",
					is_fuzzy = true,
				})
			end),
		},
	},
}

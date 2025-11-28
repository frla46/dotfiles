---@diagnostic disable: undefined-global
local wezterm = require("wezterm")
local act = wezterm.action

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

	local is_first = tab.tab_id == tabs[1].tab_id
	local is_last = tab.tab_id == tabs[#tabs].tab_id

	local background, foreground
	if tab.is_active then
		background = ACTIVE_TAB_BG
		foreground = ACTIVE_TAB_FG
	elseif hover then
		background = HOVER_TAB_BG
		foreground = HOVER_TAB_FG
	else
		background = NORMAL_TAB_BG
		foreground = NORMAL_TAB_FG
	end

	local leading_fg = NORMAL_TAB_BG
	local leading_bg = background
	local trailing_fg = background
	local trailing_bg = NORMAL_TAB_BG

	if is_first then
		return {
			{ Background = { Color = background } },
			{ Foreground = { Color = foreground } },
			{ Text = " " .. title .. " " },
			{ Background = { Color = trailing_bg } },
			{ Foreground = { Color = trailing_fg } },
			{ Text = SOLID_RIGHT_ARROW },
		}
	end

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
	},
}

---@diagnostic disable: undefined-global
--- bookmark.lua ---

-- options --
local output_path = os.getenv("HOME") .. "/.config/mpv/mpv_bookmark.csv"
local save_bookmark_keybind = "ctrl+b"
-------------

local function write_bookmark()
	local filename = mp.get_property("filename") or "N/A"
	local path = mp.get_property("path") or "N/A"
	local time = mp.get_property("time-pos") or "0"
	local line = string.format('"%s","%s","%s"\n', filename, path, time)

	local file = io.open(output_path, "a")
	if file then
		file:write(line)
		file:close()
		mp.osd_message("Write succeeded: " .. filename .. " @" .. time)
	else
		mp.osd_message("Write failed.")
	end
end

mp.add_forced_key_binding(save_bookmark_keybind, "bookmark-to-file", write_bookmark)

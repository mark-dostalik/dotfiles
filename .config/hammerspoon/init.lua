hs.autoLaunch(true)

-- Maximize application windows when they open.
-- A dedicated filter restricted to standard windows keeps transient system
-- HUDs (the volume/brightness on-screen display, notifications, Spotlight,
-- etc.) from being grabbed and flung around the screen.
local maximizeFilter = hs.window.filter.new(false):setDefaultFilter({ allowRoles = "AXStandardWindow" })

maximizeFilter:subscribe(hs.window.filter.windowCreated, function(win)
	if win:isStandard() then
		win:maximize()
	end
end)

hs.loadSpoon("ClipboardTool")
spoon.ClipboardTool.hist_size = 50
spoon.ClipboardTool.show_in_menubar = false
spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool:start()
spoon.ClipboardTool:bindHotkeys({ toggle_clipboard = { { "cmd", "shift" }, "v" } })

hs.loadSpoon("FnMate")

-- 1. Remap Dictation key (0xC000000CF) to Keyboard Brightness Down (0xFF00000009)
-- 2. Remap Do Not Disturb key (0x10000009B) to Keyboard Brightness Up (0xFF00000008)
-- 3. Remap Caps Lock (0x700000039) to Left Control (0x7000000E0)
-- 4. Remap § (0x700000035) to ` (0x700000064)
-- 5. Remap ` (0x700000064) to § (0x700000035)
local json = [[
{
  "UserKeyMapping": [
    {
      "HIDKeyboardModifierMappingSrc": 0xC000000CF,
      "HIDKeyboardModifierMappingDst": 0xFF00000009
    },
    {
      "HIDKeyboardModifierMappingSrc": 0x10000009B,
      "HIDKeyboardModifierMappingDst": 0xFF00000008
    },
    {
      "HIDKeyboardModifierMappingSrc": 0x700000039,
      "HIDKeyboardModifierMappingDst": 0x7000000E0
    },
    {
      "HIDKeyboardModifierMappingSrc": 0x700000035,
      "HIDKeyboardModifierMappingDst": 0x700000064
    },
    {
      "HIDKeyboardModifierMappingSrc": 0x700000064,
      "HIDKeyboardModifierMappingDst": 0x700000035
    }
  ]
}
]]
hs.task
	.new("/usr/bin/hidutil", nil, {
		"property",
		"--set",
		json,
	})
	:start()

hs.autoLaunch(true)

-- Maximize application windows when they open.
-- A dedicated filter restricted to standard windows keeps transient system
-- HUDs (the volume/brightness on-screen display, notifications, Spotlight,
-- etc.) from being grabbed and flung around the screen.
local maximizeFilter = hs.window.filter.new(false)
  :setDefaultFilter({ allowRoles = "AXStandardWindow" })

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
spoon.ClipboardTool:bindHotkeys({ toggle_clipboard = {{"cmd", "shift"}, "v"} })

hs.loadSpoon("FnMate")

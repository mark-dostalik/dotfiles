hs.autoLaunch(true)

hs.window.filter.default:subscribe(hs.window.filter.windowCreated, function(win)
  win:maximize()
end)

hs.loadSpoon("ClipboardTool")
spoon.ClipboardTool.hist_size = 50
spoon.ClipboardTool.show_in_menubar = false
spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool:start()
spoon.ClipboardTool:bindHotkeys({ toggle_clipboard = {{"cmd", "shift"}, "v"} })

hs.loadSpoon("FnMate")

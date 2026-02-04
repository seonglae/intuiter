-- Intuiter for macOS - Hammerspoon Configuration
-- Cross-platform keyboard/mouse control equivalent to AHK on Windows

-- Load modules
local mouse = require("mouse")
local text = require("text")
local config = require("config")

-- Initialize
hs.alert.show("Intuiter Loaded")

-- Store references for cleanup
intuiter = {
    mouse = mouse,
    text = text,
    config = config
}

-- Reload configuration hotkey (Cmd+Ctrl+R)
hs.hotkey.bind({"cmd", "ctrl"}, "r", function()
    hs.reload()
end)

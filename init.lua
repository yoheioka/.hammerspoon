local alert = require 'hs.alert'

import = require('utils/import')
import.clear_cache()

config = import('config')

-- CONFIG FOR CAPS LOCK HACKING START
-- reference: https://github.com/lodestone/hyper-hacks/blob/master/hammerspoon/init.lua
-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")

local application_shortcuts = {
    b = "Google Chrome",
    u = "Sublime Text",
    t = "iTerm",
    l = "LINE",
    m = "Spotify",
    f = "Finder",
    p = "Preview",
    n = "Notes",
    s = "Slack",
    q = "MySQLWorkbench",
    c = "Visual Studio Code",
    x = "Firefox",
    w = "whatsApp",
    z = "zoom.us",
}

for key, app_name in pairs(application_shortcuts) do
    appfun = function()
        hs.application.launchOrFocus(app_name)
        k.triggered = true
    end
    k:bind('', key, nil, appfun)
end

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
    k.triggered = false
    k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is released,
releasedF18 = function()
    k:exit()
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)
-- CONFIG FOR CAPS LOCK HACKING END

-- move application to different windows
k:bind('', '/', nil, function()
    -- get the focused window
    local win = hs.window.focusedWindow()
    -- get the screen where the focused window is displayed, a.k.a. current screen
    local screen = win:screen()
    -- compute the unitRect of the focused window relative to the current screen
    -- and move the window to the next screen setting the same unitRect
    win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)


function config:get(key_path, default)
    local root = self
    for part in string.gmatch(key_path, "[^\\.]+") do
        root = root[part]
        if root == nil then
            return default
        end
    end
    return root
end

local modules = {}

for _, v in ipairs(config.modules) do
    local module_name = 'modules/' .. v
    local module = import(module_name)

    if type(module.init) == "function" then
        module.init()
    end

    table.insert(modules, module)
end

local buf = {}

if hs.wasLoaded == nil then
    hs.wasLoaded = true
    table.insert(buf, "Hammerspoon loaded: ")
else
    table.insert(buf, "Hammerspoon re-loaded: ")
end

table.insert(buf, #modules .. " modules.")

alert.show(table.concat(buf))

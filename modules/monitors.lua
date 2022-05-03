local hotkey = require 'hs.hotkey'
local window = require 'hs.window'
local geometry = require 'hs.geometry'
local mouse = require 'hs.mouse'

local position = import('utils/position')
local monitors = import('utils/monitors')

local function init_module()
    for id, monitor in pairs(monitors.configured_monitors) do

        hotkey.bind({ "cmd", "ctrl" }, "PAD" .. id, function()
            local midpoint = geometry.rectMidPoint(monitor.dimensions)
            mouse.set(midpoint)
        end)

        hotkey.bind({ "cmd", "ctrl", "alt" }, "PAD" .. id, function()
            local win = window.focusedWindow()
            if win ~= nil then
                win:setFrame(position.full(monitor.dimensions))
            end
        end)

        hotkey.bind({ "ctrl", "alt" }, "PAD" .. id, function()
            local win = window.focusedWindow()
            if win ~= nil then
                win:setFrame(position.left(monitor.dimensions))
            end
        end)

        hotkey.bind({ "cmd", "alt" }, "PAD" .. id, function()
            local win = window.focusedWindow()
            if win ~= nil then
                win:setFrame(position.right(monitor.dimensions))
            end
        end)
        hotkey.bind({ "shift", "ctrl", "alt" }, "PAD" .. id, function()
            local win = window.focusedWindow()
            if win ~= nil then
                win:setFrame(monitor.dimensions:relative_window_position(win))
            end
        end)
    end
end

return {
    init = init_module
}

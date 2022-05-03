local hotkey = require 'hs.hotkey'
local window = require 'hs.window'

local position = import('utils/position')
local monitors = import('utils/monitors')

local function module_init()
    local keys = config:get("arrows.keys", {
        UP = "top",
        DOWN = "bottom",
        LEFT = "left",
        RIGHT = "right",
        SPACE = "full",
        ["1"] = "top_right",
        ["2"] = "bottom_right",
        ["3"] = "bottom_left",
        ["4"] = "top_left",
        ["7"] = "left_third",
        ["8"] = "middle_third",
        ["9"] = "right_third"
    })


    for key, position_string in pairs(keys) do
        local position_fn = position[position_string]

        if position_fn == nil then
            error("arrow: " .. position_string .. " is not a valid position")
        end

        k:bind('', key, nil, function()
            local win = window.focusedWindow()
            if win == nil then
                return
            end

            local screen = win:screen()
            local dimensions = monitors.get_screen_dimensions(screen)
            local newframe = position_fn(dimensions)

            win:setFrame(newframe)
        end)
    end
end

return {
    init = module_init
}
local hotkey = require 'hs.hotkey'

return {
    init = function()
        hotkey.bind(config:get("reload.mash", { "cmd", "ctrl", "alt" }), config:get("reload.key", "E"), hs.reload)
    end
}

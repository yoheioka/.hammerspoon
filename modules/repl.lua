local hotkey = require 'hs.hotkey'

return {
    init = function()
        hotkey.bind(config:get("repl.mash", { "cmd", "ctrl", "alt" }), config:get("repl.key", "R"), hs.openConsole)
    end
}

local hotkey = require 'hs.hotkey'

local function module_init()
    local mash = config:get("lock.mash", {})
    local key = config:get("lock.key", "F13")

    hotkey.bind(mash, key, function()
        os.execute("/System/Library/CoreServices/Menu\\ Extras/User.menu/Contents/Resources/CGSession -suspend")
    end)

end

return {
    init = module_init
}

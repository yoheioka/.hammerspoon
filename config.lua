local config = {}

config.modules = {
    "arrangement",
    "monitors",
    "arrows",
    "fullscreen"
}

-- Maps monitor id -> screen index.
config.monitors = {
    autodiscover = true,
    rows = 1
}

-- Window arrangements.
config.arrangements = {}

return config

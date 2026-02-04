-- Intuiter Configuration for macOS
-- Equivalent to packages/ahk/lib/const.ahk

local config = {}

-- Mouse movement settings
config.mouse = {
    maxVelocity = 5,        -- MAX_V: Maximum velocity
    acceleration = 0.2,     -- V_ACCEL: Acceleration rate
    xVelocity = 4,          -- X_V: X-axis velocity factor
    yVelocity = 3,          -- Y_V: Y-axis velocity factor
    axisVelocity = 5,       -- AXIS_V: Single-axis velocity
    pollInterval = 0.001,   -- Polling interval in seconds (1ms like AHK)
}

-- Scroll settings
config.scroll = {
    divisor = 3,            -- SCROLL_DIVISOR
    dividend = 400,         -- SCROLL_DIVIDIEND
    acceleration = 1,       -- SCROLL_ACCEL
}

-- Modifier key mappings
-- On Mac, we use Cmd (Command) as the primary modifier instead of Win key
-- Alt (Option) remains the same
config.modifiers = {
    primary = "cmd",        -- Windows key equivalent on Mac
    secondary = "alt",      -- Alt key (Option)
    tertiary = "ctrl",      -- Control key
    shift = "shift",        -- Shift key
}

return config

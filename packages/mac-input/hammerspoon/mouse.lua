-- Intuiter Mouse Control for macOS
-- Equivalent to packages/ahk/lib/mouse_func.ahk and src/right/mouse.ahk

local config = require("config")

local mouse = {}

-- State tracking
local state = {
    velocity = 0,
    moveTimer = nil,
    scrollTimer = nil,
    keysPressed = {},
}

-- Track key states
local function isKeyPressed(key)
    return state.keysPressed[key] == true
end

local function setKeyPressed(key, pressed)
    state.keysPressed[key] = pressed
end

-- Mouse relative movement function (equivalent to MouseRelativeMove in AHK)
local function mouseRelativeMove(dx, dy)
    local pos = hs.mouse.absolutePosition()
    hs.mouse.absolutePosition({
        x = pos.x + dx,
        y = pos.y + dy
    })
end

-- Calculate diagonal movement
local function getDiagonalMove(velocity, cos, sin, dirX, dirY)
    local dx = cos * velocity * dirX
    local dy = sin * velocity * dirY
    return dx, dy
end

-- Stop mouse movement
local function stopMouseMove()
    if state.moveTimer then
        state.moveTimer:stop()
        state.moveTimer = nil
    end
    state.velocity = 0
end

-- Generic mouse movement function
local function startMouseMove(dirX, dirY)
    stopMouseMove()
    state.velocity = 0

    local cfg = config.mouse
    local cos = cfg.xVelocity / cfg.axisVelocity
    local sin = cfg.yVelocity / cfg.axisVelocity

    state.moveTimer = hs.timer.doEvery(cfg.pollInterval, function()
        -- Check if Ctrl is held for instant max speed
        if hs.eventtap.checkKeyboardModifiers().ctrl then
            state.velocity = cfg.maxVelocity
        end

        -- Calculate movement based on which keys are pressed
        local dx, dy = 0, 0
        local moving = false

        -- Diagonal movements (IJKL combinations)
        if isKeyPressed("i") and isKeyPressed("l") then
            dx, dy = getDiagonalMove(state.velocity, cos, sin, 1, -1)
            moving = true
        elseif isKeyPressed("i") and isKeyPressed("j") then
            dx, dy = getDiagonalMove(state.velocity, cos, sin, -1, -1)
            moving = true
        elseif isKeyPressed("k") and isKeyPressed("l") then
            dx, dy = getDiagonalMove(state.velocity, cos, sin, 1, 1)
            moving = true
        elseif isKeyPressed("k") and isKeyPressed("j") then
            dx, dy = getDiagonalMove(state.velocity, cos, sin, -1, 1)
            moving = true
        -- Single direction movements
        elseif isKeyPressed("i") then
            dy = -cfg.axisVelocity * state.velocity
            moving = true
        elseif isKeyPressed("k") then
            dy = cfg.axisVelocity * state.velocity
            moving = true
        elseif isKeyPressed("j") then
            dx = -cfg.axisVelocity * state.velocity
            moving = true
        elseif isKeyPressed("l") then
            dx = cfg.axisVelocity * state.velocity
            moving = true
        end

        if moving then
            mouseRelativeMove(dx, dy)
            if state.velocity < cfg.maxVelocity then
                state.velocity = state.velocity + cfg.acceleration
            end
        else
            stopMouseMove()
        end
    end)
end

-- Mouse click functions (equivalent to click_left, click_right, click_mid in AHK)
local function mouseClick(button)
    local pos = hs.mouse.absolutePosition()
    hs.eventtap.event.newMouseEvent(
        hs.eventtap.event.types[button .. "MouseDown"],
        pos
    ):post()
    hs.eventtap.event.newMouseEvent(
        hs.eventtap.event.types[button .. "MouseUp"],
        pos
    ):post()
end

local function mouseDown(button)
    local pos = hs.mouse.absolutePosition()
    hs.eventtap.event.newMouseEvent(
        hs.eventtap.event.types[button .. "MouseDown"],
        pos
    ):post()
end

local function mouseUp(button)
    local pos = hs.mouse.absolutePosition()
    hs.eventtap.event.newMouseEvent(
        hs.eventtap.event.types[button .. "MouseUp"],
        pos
    ):post()
end

-- Scroll functions (equivalent to scroll_up, scroll_down, etc. in AHK)
local scrollState = {
    timer = nil,
    divisor = 3,
}

local function stopScroll()
    if scrollState.timer then
        scrollState.timer:stop()
        scrollState.timer = nil
    end
    scrollState.divisor = config.scroll.divisor
end

local function startScroll(dx, dy)
    stopScroll()
    scrollState.divisor = config.scroll.divisor

    scrollState.timer = hs.timer.doEvery(0.01, function()
        if hs.eventtap.checkKeyboardModifiers().ctrl then
            scrollState.divisor = 10
        end

        hs.eventtap.event.newScrollEvent(
            {dx * 10, dy * 10},
            {},
            "pixel"
        ):post()

        scrollState.divisor = scrollState.divisor + config.scroll.acceleration
    end)
end

-- Key bindings for mouse movement (Cmd + IJKL)
-- Equivalent to Lwin & i, Lwin & k, Lwin & j, Lwin & l in AHK
local moveKeys = {"i", "j", "k", "l"}
local moveBindings = {}

for _, key in ipairs(moveKeys) do
    -- Key down
    moveBindings[key .. "_down"] = hs.hotkey.bind({"cmd"}, key, function()
        setKeyPressed(key, true)
        startMouseMove()
    end, function()
        setKeyPressed(key, false)
    end)
end

-- Mouse click bindings (Cmd + U for left click, Cmd + O for right click)
-- Equivalent to Lwin & u, Lwin & o in AHK
local leftClickBinding = hs.hotkey.bind({"cmd"}, "u", function()
    mouseDown("left")
end, function()
    mouseUp("left")
end)

local rightClickBinding = hs.hotkey.bind({"cmd"}, "o", function()
    mouseDown("right")
end, function()
    mouseUp("right")
end)

-- Middle click (Cmd + M)
local midClickBinding = hs.hotkey.bind({"cmd"}, "m", function()
    mouseDown("middle")
end, function()
    mouseUp("middle")
end)

-- Scroll bindings (Alt + U for scroll up, Alt + O for scroll down)
-- Equivalent to Lalt & u, Lalt & o in AHK
local scrollUpBinding = hs.hotkey.bind({"alt"}, "u", function()
    startScroll(0, 5)
end, function()
    stopScroll()
end)

local scrollDownBinding = hs.hotkey.bind({"alt"}, "o", function()
    startScroll(0, -5)
end, function()
    stopScroll()
end)

-- Horizontal scroll with Shift modifier
local scrollLeftBinding = hs.hotkey.bind({"alt", "shift"}, "u", function()
    startScroll(5, 0)
end, function()
    stopScroll()
end)

local scrollRightBinding = hs.hotkey.bind({"alt", "shift"}, "o", function()
    startScroll(-5, 0)
end, function()
    stopScroll()
end)

-- Additional scroll binding (Cmd + H for scroll up, Cmd + P for scroll down)
local scrollUpAltBinding = hs.hotkey.bind({"cmd"}, "h", function()
    startScroll(0, 5)
end, function()
    stopScroll()
end)

local scrollDownAltBinding = hs.hotkey.bind({"cmd"}, "p", function()
    startScroll(0, -5)
end, function()
    stopScroll()
end)

-- Store bindings for cleanup
mouse.bindings = {
    moveBindings,
    leftClickBinding,
    rightClickBinding,
    midClickBinding,
    scrollUpBinding,
    scrollDownBinding,
    scrollLeftBinding,
    scrollRightBinding,
    scrollUpAltBinding,
    scrollDownAltBinding,
}

mouse.stop = stopMouseMove
mouse.stopScroll = stopScroll

return mouse

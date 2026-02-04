-- Intuiter Text Navigation for macOS
-- Equivalent to packages/ahk/src/right/arrow_ijkl.ahk and src/left/text_select.ahk

local config = require("config")

local text = {}

-- Helper function to send key events
local function sendKey(key, modifiers)
    modifiers = modifiers or {}
    hs.eventtap.keyStroke(modifiers, key, 0)
end

-- Helper for repeated key sending while held
local function createRepeatingKey(modifiers, key, targetKey, targetMods)
    local timer = nil

    return hs.hotkey.bind(modifiers, key, function()
        -- First press
        sendKey(targetKey, targetMods)

        -- Start repeating
        timer = hs.timer.doEvery(0.001, function()
            sendKey(targetKey, targetMods)
        end)
    end, function()
        -- Key released
        if timer then
            timer:stop()
            timer = nil
        end
    end)
end

-- Text navigation bindings (Alt + IJKL)
-- Equivalent to Lalt & i, Lalt & k, Lalt & j, Lalt & l in AHK

-- Alt + I: Up arrow (single press)
-- Alt + Shift + I: Select up
-- Alt + Ctrl + I: Repeat up while held
-- Alt + Ctrl + Shift + I: Repeat select up while held
local textUpBinding = hs.hotkey.bind({"alt"}, "i", function()
    if hs.eventtap.checkKeyboardModifiers().shift and hs.eventtap.checkKeyboardModifiers().ctrl then
        -- Repeating select up - handled by separate binding
    elseif hs.eventtap.checkKeyboardModifiers().shift then
        sendKey("up", {"shift"})
    elseif hs.eventtap.checkKeyboardModifiers().ctrl then
        -- Repeating up - handled by separate binding
    else
        sendKey("up")
    end
end)

local textUpRepeatBinding = createRepeatingKey({"alt", "ctrl"}, "i", "up", {})
local textUpSelectRepeatBinding = createRepeatingKey({"alt", "ctrl", "shift"}, "i", "up", {"shift"})
local textUpSelectBinding = hs.hotkey.bind({"alt", "shift"}, "i", function()
    sendKey("up", {"shift"})
end)

-- Alt + K: Down arrow
local textDownBinding = hs.hotkey.bind({"alt"}, "k", function()
    sendKey("down")
end)

local textDownRepeatBinding = createRepeatingKey({"alt", "ctrl"}, "k", "down", {})
local textDownSelectRepeatBinding = createRepeatingKey({"alt", "ctrl", "shift"}, "k", "down", {"shift"})
local textDownSelectBinding = hs.hotkey.bind({"alt", "shift"}, "k", function()
    sendKey("down", {"shift"})
end)

-- Alt + J: Word left (Ctrl+Left on Windows = Option+Left on Mac)
local textWordLeftBinding = hs.hotkey.bind({"alt"}, "j", function()
    sendKey("left", {"alt"})
end)

-- Alt + Shift + J: Select word left
local textWordLeftSelectBinding = hs.hotkey.bind({"alt", "shift"}, "j", function()
    sendKey("left", {"alt", "shift"})
end)

-- Alt + Ctrl + J: Repeat left while held
local textLeftRepeatBinding = createRepeatingKey({"alt", "ctrl"}, "j", "left", {})

-- Alt + Ctrl + Shift + J: Select to beginning of line
local textSelectToHomeBinding = hs.hotkey.bind({"alt", "ctrl", "shift"}, "j", function()
    sendKey("left", {"cmd", "shift"})
end)

-- Alt + L: Word right (Ctrl+Right on Windows = Option+Right on Mac)
local textWordRightBinding = hs.hotkey.bind({"alt"}, "l", function()
    sendKey("right", {"alt"})
end)

-- Alt + Shift + L: Select word right
local textWordRightSelectBinding = hs.hotkey.bind({"alt", "shift"}, "l", function()
    sendKey("right", {"alt", "shift"})
end)

-- Alt + Ctrl + L: Repeat right while held
local textRightRepeatBinding = createRepeatingKey({"alt", "ctrl"}, "l", "right", {})

-- Alt + Ctrl + Shift + L: Select to end of line
local textSelectToEndBinding = hs.hotkey.bind({"alt", "ctrl", "shift"}, "l", function()
    sendKey("right", {"cmd", "shift"})
end)

-- Text selection shortcuts (Alt + W and Alt + A)
-- Equivalent to Lalt & w, Lalt & a in AHK

-- Alt + W: Select word (first press), select line (second press)
local selectState = {
    pressCount = 0,
    timer = nil,
}

local textSelectWordBinding = hs.hotkey.bind({"alt"}, "w", function()
    if selectState.timer then
        selectState.timer:stop()
    end

    selectState.pressCount = selectState.pressCount + 1

    if selectState.pressCount == 1 then
        -- Select word: move left, then Ctrl+Right, then Shift+Ctrl+Left
        sendKey("left")
        hs.timer.doAfter(0.01, function()
            sendKey("right", {"alt"})
            hs.timer.doAfter(0.01, function()
                sendKey("left", {"alt", "shift"})
            end)
        end)
    elseif selectState.pressCount == 2 then
        -- Select line: End then Shift+Home
        sendKey("right", {"cmd"})
        hs.timer.doAfter(0.01, function()
            sendKey("left", {"cmd", "shift"})
        end)
        selectState.pressCount = 0
    end

    -- Reset count after timeout
    selectState.timer = hs.timer.doAfter(0.3, function()
        selectState.pressCount = 0
    end)
end)

-- Alt + Shift + W: Select entire line
local textSelectLineBinding = hs.hotkey.bind({"alt", "shift"}, "w", function()
    sendKey("left", {"cmd"})
    hs.timer.doAfter(0.01, function()
        sendKey("right", {"cmd", "shift"})
    end)
end)

-- Alt + Ctrl + W: Select current and next line
local textSelectMultiLineBinding = hs.hotkey.bind({"alt", "ctrl"}, "w", function()
    sendKey("up")
    hs.timer.doAfter(0.01, function()
        sendKey("right", {"cmd"})
        hs.timer.doAfter(0.01, function()
            sendKey("down", {"shift"})
            hs.timer.doAfter(0.01, function()
                sendKey("right", {"cmd", "shift"})
            end)
        end)
    end)
end)

-- Alt + A: Select line (first press), select paragraph (second press)
local selectAState = {
    pressCount = 0,
    timer = nil,
}

local textSelectABinding = hs.hotkey.bind({"alt"}, "a", function()
    if selectAState.timer then
        selectAState.timer:stop()
    end

    selectAState.pressCount = selectAState.pressCount + 1

    if selectAState.pressCount == 1 then
        -- Select line: End then Shift+Home
        sendKey("right", {"cmd"})
        hs.timer.doAfter(0.01, function()
            sendKey("left", {"cmd", "shift"})
        end)
    elseif selectAState.pressCount == 2 then
        -- Select paragraph
        sendKey("up")
        hs.timer.doAfter(0.01, function()
            sendKey("right", {"cmd"})
            hs.timer.doAfter(0.01, function()
                sendKey("down", {"shift"})
                hs.timer.doAfter(0.01, function()
                    sendKey("right", {"cmd", "shift"})
                end)
            end)
        end)
        selectAState.pressCount = 0
    end

    -- Reset count after timeout
    selectAState.timer = hs.timer.doAfter(0.3, function()
        selectAState.pressCount = 0
    end)
end)

-- Home and End shortcuts using Alt + U/O with Ctrl+Shift
-- Alt + Ctrl + Shift + U: Go to beginning of document
local textHomeDocBinding = hs.hotkey.bind({"alt", "ctrl", "shift"}, "u", function()
    sendKey("up", {"cmd"})
end)

-- Alt + Ctrl + Shift + O: Go to end of document
local textEndDocBinding = hs.hotkey.bind({"alt", "ctrl", "shift"}, "o", function()
    sendKey("down", {"cmd"})
end)

-- Store bindings for cleanup
text.bindings = {
    textUpBinding,
    textUpRepeatBinding,
    textUpSelectRepeatBinding,
    textUpSelectBinding,
    textDownBinding,
    textDownRepeatBinding,
    textDownSelectRepeatBinding,
    textDownSelectBinding,
    textWordLeftBinding,
    textWordLeftSelectBinding,
    textLeftRepeatBinding,
    textSelectToHomeBinding,
    textWordRightBinding,
    textWordRightSelectBinding,
    textRightRepeatBinding,
    textSelectToEndBinding,
    textSelectWordBinding,
    textSelectLineBinding,
    textSelectMultiLineBinding,
    textSelectABinding,
    textHomeDocBinding,
    textEndDocBinding,
}

return text

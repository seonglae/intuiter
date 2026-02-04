# @intuiter/mac-input

macOS keyboard/mouse control for Intuiter, equivalent to the Windows AHK package.

## Overview

This package provides cross-platform input control for macOS using [Hammerspoon](https://www.hammerspoon.org/), a powerful macOS automation tool with Lua scripting.

## Features

### Mouse Control (Cmd + IJKL)
- **Cmd + I/K/J/L**: Move mouse up/down/left/right
- **Diagonal movement**: Hold two keys for diagonal (e.g., Cmd + I + L for up-right)
- **Speed boost**: Hold Ctrl for instant maximum speed
- **Acceleration**: Movement starts slow and accelerates (configurable)

### Mouse Clicks
- **Cmd + U**: Left click (hold for drag)
- **Cmd + O**: Right click
- **Cmd + M**: Middle click

### Scrolling
- **Alt + U/O**: Scroll up/down
- **Alt + Shift + U/O**: Scroll left/right
- **Cmd + H**: Scroll up (alternate)
- **Cmd + P**: Scroll down (alternate)

### Text Navigation (Alt + IJKL)
- **Alt + I/K**: Arrow up/down
- **Alt + J/L**: Word left/right (Option+Arrow on Mac)
- **Alt + Shift + variants**: Select while moving
- **Alt + Ctrl + variants**: Repeat while held

### Text Selection
- **Alt + W**: Select word (press twice for line)
- **Alt + A**: Select line (press twice for paragraph)
- **Alt + Shift + W**: Select entire line
- **Alt + Ctrl + W**: Select multiple lines

## Installation

### Prerequisites
- macOS 10.12 or later
- [Homebrew](https://brew.sh/) (recommended for installing Hammerspoon)

### Automatic Installation

```bash
cd packages/mac-input
npm run install
```

This will:
1. Install Hammerspoon via Homebrew (if not already installed)
2. Copy the Lua configuration to `~/.hammerspoon/`
3. Reload Hammerspoon

### Manual Installation

1. Install Hammerspoon:
   ```bash
   brew install --cask hammerspoon
   ```

2. Copy configuration files to `~/.hammerspoon/`:
   - `init.lua`
   - `config.lua`
   - `mouse.lua`
   - `text.lua`

3. Grant Accessibility permissions:
   - System Preferences > Security & Privacy > Privacy > Accessibility
   - Add and enable Hammerspoon

4. Start Hammerspoon and reload config (Cmd + Ctrl + R)

## Configuration

Edit `~/.hammerspoon/config.lua` to customize:

```lua
config.mouse = {
    maxVelocity = 5,      -- Maximum mouse speed
    acceleration = 0.2,    -- Speed increase rate
    xVelocity = 4,        -- Diagonal X factor
    yVelocity = 3,        -- Diagonal Y factor
    axisVelocity = 5,     -- Single-axis speed
    pollInterval = 0.001, -- Update frequency (1ms)
}
```

## Comparison with Windows AHK

| Feature | Windows (AHK) | macOS (Hammerspoon) |
|---------|---------------|---------------------|
| Mouse movement | LWin + IJKL | Cmd + IJKL |
| Left click | LWin + U | Cmd + U |
| Right click | LWin + O | Cmd + O |
| Scroll | LAlt + U/O | Alt + U/O |
| Text navigation | LAlt + IJKL | Alt + IJKL |
| Modifier | LWin (Windows key) | Cmd (Command key) |

## Uninstallation

```bash
cd packages/mac-input
npm run uninstall
```

Or manually remove the files from `~/.hammerspoon/`.

## Troubleshooting

### "Hammerspoon can't control this application"
Grant Accessibility permissions in System Preferences.

### Keys not working
1. Check if Hammerspoon is running (menubar icon)
2. Reload config: Cmd + Ctrl + R
3. Check Console.app for Hammerspoon errors

### Conflicts with other shortcuts
Some applications may capture these shortcuts. You can customize the modifier keys in `config.lua`.

## License

MIT - Same as the main Intuiter project.

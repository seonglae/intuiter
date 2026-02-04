# @intuiter/mac-input

macOS keyboard/mouse control for Intuiter using [Hammerspoon](https://www.hammerspoon.org/).

## Features

### Mouse Control (Cmd + IJKL)
- **Cmd + I/K/J/L**: Move mouse up/down/left/right
- **Diagonal**: Hold two keys (e.g., Cmd + I + L for up-right)
- **Speed**: Hold Ctrl for instant max speed

### Mouse Clicks
- **Cmd + U**: Left click (hold for drag)
- **Cmd + O**: Right click
- **Cmd + M**: Middle click

### Scrolling
- **Alt + U/O**: Scroll up/down
- **Alt + Shift + U/O**: Scroll left/right
- **Cmd + H/P**: Scroll up/down (alternate)

### Text Navigation (Alt + IJKL)
- **Alt + I/K**: Arrow up/down
- **Alt + J/L**: Word left/right
- **Alt + Shift + variants**: Select while moving
- **Alt + Ctrl + variants**: Repeat while held

### Text Selection
- **Alt + W**: Select word (press twice for line)
- **Alt + A**: Select line (press twice for paragraph)
- **Alt + Shift + W**: Select entire line

## Installation

### Via npm
```bash
cd packages/mac-input
npm run install-config
```

### Manual
1. Install Hammerspoon: `brew install --cask hammerspoon`
2. Copy files from `hammerspoon/` to `~/.hammerspoon/`
3. Grant Accessibility permissions in System Preferences
4. Reload config: Cmd + Ctrl + R

## Configuration

Edit `~/.hammerspoon/config.lua`:

```lua
config.mouse = {
    maxVelocity = 5,
    acceleration = 0.2,
    pollInterval = 0.001,
}
```

## Windows/Mac Comparison

| Feature | Windows (AHK) | macOS (Hammerspoon) |
|---------|---------------|---------------------|
| Mouse movement | LWin + IJKL | Cmd + IJKL |
| Clicks | LWin + U/O | Cmd + U/O |
| Text nav | LAlt + IJKL | Alt + IJKL |

## License

MIT

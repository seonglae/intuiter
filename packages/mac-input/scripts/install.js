#!/usr/bin/env node
/**
 * Intuiter macOS Installation Script
 * Installs Hammerspoon configuration for keyboard/mouse control
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const os = require('os');

const HAMMERSPOON_CONFIG_DIR = path.join(os.homedir(), '.hammerspoon');
const SOURCE_DIR = path.join(__dirname, '..', 'hammerspoon');

function log(message) {
    console.log(`[Intuiter] ${message}`);
}

function error(message) {
    console.error(`[Intuiter Error] ${message}`);
}

function checkHammerspoon() {
    try {
        execSync('which hs', { stdio: 'pipe' });
        return true;
    } catch {
        return false;
    }
}

function checkHammerspoonApp() {
    return fs.existsSync('/Applications/Hammerspoon.app');
}

function installHammerspoon() {
    log('Hammerspoon not found. Attempting to install via Homebrew...');

    try {
        // Check if Homebrew is installed
        execSync('which brew', { stdio: 'pipe' });
    } catch {
        error('Homebrew is not installed. Please install Homebrew first:');
        error('  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"');
        error('Then run this installation again.');
        process.exit(1);
    }

    try {
        log('Installing Hammerspoon via Homebrew Cask...');
        execSync('brew install --cask hammerspoon', { stdio: 'inherit' });
        log('Hammerspoon installed successfully!');
    } catch (e) {
        error(`Failed to install Hammerspoon: ${e.message}`);
        error('Please install Hammerspoon manually from: https://www.hammerspoon.org/');
        process.exit(1);
    }
}

function backupExistingConfig() {
    const initFile = path.join(HAMMERSPOON_CONFIG_DIR, 'init.lua');
    if (fs.existsSync(initFile)) {
        const backupFile = path.join(HAMMERSPOON_CONFIG_DIR, 'init.lua.backup');
        log(`Backing up existing init.lua to ${backupFile}`);
        fs.copyFileSync(initFile, backupFile);
    }
}

function installConfig() {
    log('Installing Intuiter Hammerspoon configuration...');

    // Create config directory if it doesn't exist
    if (!fs.existsSync(HAMMERSPOON_CONFIG_DIR)) {
        fs.mkdirSync(HAMMERSPOON_CONFIG_DIR, { recursive: true });
    }

    // Backup existing config
    backupExistingConfig();

    // Copy all Lua files
    const files = ['init.lua', 'config.lua', 'mouse.lua', 'text.lua'];

    for (const file of files) {
        const source = path.join(SOURCE_DIR, file);
        const dest = path.join(HAMMERSPOON_CONFIG_DIR, file);

        if (fs.existsSync(source)) {
            fs.copyFileSync(source, dest);
            log(`  Installed ${file}`);
        } else {
            error(`  Source file not found: ${source}`);
        }
    }

    log('Configuration installed successfully!');
}

function reloadHammerspoon() {
    log('Reloading Hammerspoon configuration...');

    try {
        // Try using the hs CLI if available
        execSync('hs -c "hs.reload()"', { stdio: 'pipe' });
        log('Hammerspoon reloaded!');
    } catch {
        log('Could not reload automatically. Please reload Hammerspoon manually.');
        log('  Click the Hammerspoon menubar icon and select "Reload Config"');
        log('  Or press Cmd+Ctrl+R if Intuiter is already loaded');
    }
}

function printInstructions() {
    log('');
    log('=== Setup Complete ===');
    log('');
    log('Important: Hammerspoon needs Accessibility permissions to control input.');
    log('');
    log('1. Open System Preferences > Security & Privacy > Privacy > Accessibility');
    log('2. Click the lock icon to make changes');
    log('3. Add Hammerspoon to the list and enable it');
    log('');
    log('If Hammerspoon is not running, start it from Applications.');
    log('');
    log('=== Key Bindings ===');
    log('');
    log('Mouse Movement (Cmd + IJKL):');
    log('  Cmd + I: Move up');
    log('  Cmd + K: Move down');
    log('  Cmd + J: Move left');
    log('  Cmd + L: Move right');
    log('  Hold Ctrl for instant max speed');
    log('');
    log('Mouse Clicks:');
    log('  Cmd + U: Left click');
    log('  Cmd + O: Right click');
    log('  Cmd + M: Middle click');
    log('');
    log('Scroll:');
    log('  Alt + U: Scroll up');
    log('  Alt + O: Scroll down');
    log('  Alt + Shift + U: Scroll left');
    log('  Alt + Shift + O: Scroll right');
    log('');
    log('Text Navigation (Alt + IJKL):');
    log('  Alt + I/K: Up/Down arrow');
    log('  Alt + J/L: Word left/right');
    log('  Alt + Shift + I/K: Select up/down');
    log('  Alt + Shift + J/L: Select word left/right');
    log('  Alt + Ctrl + IJKL: Repeat key while held');
    log('');
    log('Text Selection:');
    log('  Alt + W: Select word (press twice for line)');
    log('  Alt + A: Select line (press twice for paragraph)');
    log('');
    log('Reload Config: Cmd + Ctrl + R');
    log('');
}

// Main execution
function main() {
    log('Intuiter macOS Installation');
    log('===========================');
    log('');

    // Check if we're on macOS
    if (process.platform !== 'darwin') {
        error('This installation script is for macOS only.');
        error('For Windows, please use the AHK package.');
        process.exit(1);
    }

    // Check/install Hammerspoon
    if (!checkHammerspoonApp()) {
        installHammerspoon();
    } else {
        log('Hammerspoon is already installed.');
    }

    // Install configuration
    installConfig();

    // Reload if possible
    reloadHammerspoon();

    // Print usage instructions
    printInstructions();
}

main();

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

function checkHammerspoonApp() {
    return fs.existsSync('/Applications/Hammerspoon.app');
}

function installHammerspoon() {
    log('Hammerspoon not found. Attempting to install via Homebrew...');

    try {
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

    if (!fs.existsSync(HAMMERSPOON_CONFIG_DIR)) {
        fs.mkdirSync(HAMMERSPOON_CONFIG_DIR, { recursive: true });
    }

    backupExistingConfig();

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
        execSync('hs -c "hs.reload()"', { stdio: 'pipe' });
        log('Hammerspoon reloaded!');
    } catch {
        log('Could not reload automatically. Please reload Hammerspoon manually.');
        log('  Click the Hammerspoon menubar icon and select "Reload Config"');
    }
}

function printInstructions() {
    log('');
    log('=== Setup Complete ===');
    log('');
    log('Important: Hammerspoon needs Accessibility permissions.');
    log('');
    log('1. Open System Preferences > Security & Privacy > Privacy > Accessibility');
    log('2. Add Hammerspoon to the list and enable it');
    log('');
    log('=== Key Bindings ===');
    log('');
    log('Mouse Movement (Cmd + IJKL):');
    log('  Cmd + I/K/J/L: Move up/down/left/right');
    log('  Hold Ctrl for instant max speed');
    log('');
    log('Mouse Clicks:');
    log('  Cmd + U: Left click');
    log('  Cmd + O: Right click');
    log('  Cmd + M: Middle click');
    log('');
    log('Scroll:');
    log('  Alt + U/O: Scroll up/down');
    log('');
    log('Text Navigation (Alt + IJKL):');
    log('  Alt + I/K: Up/Down arrow');
    log('  Alt + J/L: Word left/right');
    log('');
    log('Reload Config: Cmd + Ctrl + R');
    log('');
}

function main() {
    log('Intuiter macOS Installation');
    log('===========================');

    if (process.platform !== 'darwin') {
        error('This script is for macOS only.');
        process.exit(1);
    }

    if (!checkHammerspoonApp()) {
        installHammerspoon();
    } else {
        log('Hammerspoon is already installed.');
    }

    installConfig();
    reloadHammerspoon();
    printInstructions();
}

main();

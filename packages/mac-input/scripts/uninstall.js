#!/usr/bin/env node
/**
 * Intuiter macOS Uninstallation Script
 * Removes Hammerspoon configuration
 */

const fs = require('fs');
const path = require('path');
const os = require('os');

const HAMMERSPOON_CONFIG_DIR = path.join(os.homedir(), '.hammerspoon');

function log(message) {
    console.log(`[Intuiter] ${message}`);
}

function removeConfig() {
    log('Removing Intuiter Hammerspoon configuration...');

    const files = ['init.lua', 'config.lua', 'mouse.lua', 'text.lua'];

    for (const file of files) {
        const filePath = path.join(HAMMERSPOON_CONFIG_DIR, file);
        if (fs.existsSync(filePath)) {
            fs.unlinkSync(filePath);
            log(`  Removed ${file}`);
        }
    }

    // Restore backup if exists
    const backupFile = path.join(HAMMERSPOON_CONFIG_DIR, 'init.lua.backup');
    if (fs.existsSync(backupFile)) {
        const initFile = path.join(HAMMERSPOON_CONFIG_DIR, 'init.lua');
        fs.copyFileSync(backupFile, initFile);
        fs.unlinkSync(backupFile);
        log('  Restored original init.lua from backup');
    }

    log('Uninstallation complete!');
    log('');
    log('Note: Hammerspoon application was not removed.');
    log('To completely remove Hammerspoon, run: brew uninstall --cask hammerspoon');
}

// Main execution
function main() {
    log('Intuiter macOS Uninstallation');
    log('=============================');
    log('');

    if (process.platform !== 'darwin') {
        log('This script is for macOS only.');
        process.exit(1);
    }

    removeConfig();
}

main();

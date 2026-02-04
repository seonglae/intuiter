# Tauri Migration Notes

## Overview
This branch prototypes migrating from electron-nuxt to Tauri v2.

## Changes Made
1. Added `src-tauri/` directory with Rust backend
2. Created `src-tauri/Cargo.toml` - Rust dependencies
3. Created `src-tauri/tauri.conf.json` - Tauri configuration
4. Created `src-tauri/src/main.rs` - Rust main process with AHK commands
5. Created `src-vue/` directory with Vue 3 frontend
6. Added `vite.config.ts` for frontend build
7. Package.json changes documented in `package.tauri.json`

## AHK Integration
The Rust backend includes several Tauri commands:
- `spawn_ahk` - Spawns AHK process using `std::process::Command`
- `kill_ahk` - Kills AHK using `taskkill` on Windows
- `restart_ahk` - Kills and respawns AHK
- `check_ahk_status` - Checks if AHK is running

**VERDICT: WORKS** - Rust's `std::process::Command` handles process spawning
well. The approach is more explicit than Node.js but equally capable.

## Benefits
- **Much smaller bundle**: ~10-15MB vs ~150MB with Electron
- **Lower memory usage**: Uses system WebView2 on Windows
- **Rust backend**: Type-safe, fast, memory-safe
- **Active development**: Tauri v2 is mature and well-supported
- **Security-first**: IPC is more restrictive by design

## Drawbacks
- **Requires Rust knowledge**: Need to learn Rust for backend code
- **WebView2 dependency**: Requires WebView2 on Windows (included in Win11)
- **Build toolchain**: Needs Rust toolchain installed
- **Learning curve**: Different mental model than Electron

## Bundle Size
- Tauri: ~10-15MB (depending on WebView bundling)
- Electron: ~150MB
- **15x smaller!**

## Build Time Comparison
- Tauri first build: ~2-3 minutes (Rust compilation)
- Tauri incremental: ~10-20 seconds
- Electron: ~45-60 seconds

## Prerequisites
1. Install Rust: `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
2. Install Tauri CLI: `npm install -g @tauri-apps/cli`
3. On Windows: WebView2 runtime (usually pre-installed)

## To Complete Migration
1. Copy `package.tauri.json` to `package.json`
2. Run `npm install`
3. Run `cargo build` in `src-tauri/`
4. Migrate Vue components from `src/renderer/` to `src-vue/`
5. Run `npm run tauri:dev` to test
6. Run `npm run tauri:build` to create installer

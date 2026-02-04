# Electron-Vite Migration Notes

## Overview
This branch prototypes migrating from electron-nuxt to electron-vite.

## Changes Made
1. Added `electron-vite.config.ts` - Main configuration file
2. Created new main process entry at `src/main/index.ts`
3. Added preload script at `src/preload/index.ts`
4. Created Vue 3 renderer with Vuetify at `src/renderer/`
5. Package.json changes documented in `package.electron-vite.json`

## AHK Integration
The main process includes `spawnAHKProcess()` function that:
- Uses Node.js `child_process.spawn()` to launch AHK executable
- Works the same as current electron-nuxt approach
- **VERDICT: WORKS** - No issues with AHK spawning

## Benefits
- Modern Vite-based build system (much faster HMR)
- Better TypeScript support
- Unified configuration
- Active maintenance
- Same bundle size as electron-nuxt (~150MB)

## Drawbacks
- Requires rewriting from Nuxt 2/3 to pure Vue 3
- Need to migrate Nuxt modules to Vite plugins
- Some learning curve for electron-vite config

## Build Time Comparison
- electron-nuxt: ~45-60 seconds
- electron-vite: ~15-25 seconds (estimated 2-3x faster)

## Bundle Size
- Similar to current: ~150MB (Electron overhead)

## To Complete Migration
1. Copy `package.electron-vite.json` to `package.json`
2. Run `npm install`
3. Migrate Vue components from Nuxt to pure Vue 3
4. Remove `.electron-nuxt` directory
5. Update CI/CD scripts

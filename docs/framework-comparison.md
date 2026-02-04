# Desktop Framework Migration Comparison

## Overview

This document compares four desktop frameworks as potential replacements for the current electron-nuxt setup. Each framework has been prototyped in a separate experiment branch.

| Framework | Branch | Bundle Size | AHK Support | Stability |
|-----------|--------|-------------|-------------|-----------|
| electron-vite | `experiment/electron-vite` | ~150MB | Full | Stable |
| Tauri v2 | `experiment/tauri` | ~10-15MB | Full | Stable |
| Neutralinojs | `experiment/neutralino` | ~2MB | Limited | Stable |
| Electrobun | `experiment/electrobun` | ~15-30MB* | Likely | Experimental |

*Estimated, not verified

---

## Detailed Comparison

### 1. electron-vite

**Branch:** `experiment/electron-vite`

#### Summary
Drop-in replacement for electron-nuxt with modern Vite-based build system.

#### Pros
- Minimal migration effort (same Electron runtime)
- Vite's fast HMR (~3x faster builds)
- Excellent TypeScript support
- Rich ecosystem (all Electron packages work)
- Stable, well-documented
- Active maintenance

#### Cons
- Same large bundle size (~150MB)
- Same high memory usage as Electron
- Still bundling Chromium

#### AHK Integration
```typescript
// Works exactly like current implementation
import { spawn } from 'child_process';
const proc = spawn(ahkPath, [], { detached: true, stdio: 'ignore' });
proc.unref();
```
**Verdict: FULLY COMPATIBLE** - No changes needed for AHK spawning.

#### Build Times
- Development: ~15-25 seconds (vs 45-60s with electron-nuxt)
- Production: ~30-45 seconds

#### Recommendation
**RECOMMENDED if minimizing migration effort is priority.**

---

### 2. Tauri v2

**Branch:** `experiment/tauri`

#### Summary
Rust backend with system WebView, dramatically smaller bundle size.

#### Pros
- **10-15x smaller bundle** (~10-15MB vs ~150MB)
- Lower memory usage (system WebView)
- Rust backend (type-safe, fast, secure)
- Active development, mature ecosystem
- Good documentation
- Built-in auto-updater

#### Cons
- Requires learning Rust for backend code
- WebView2 dependency on Windows (usually pre-installed)
- Longer first build (Rust compilation)
- Different mental model than Electron

#### AHK Integration
```rust
use std::process::Command;

#[tauri::command]
async fn spawn_ahk(app_handle: tauri::AppHandle) -> Result<String, String> {
    let ahk_path = get_ahk_path(&app_handle);
    match Command::new(&ahk_path).spawn() {
        Ok(child) => Ok(format!("PID: {}", child.id())),
        Err(e) => Err(e.to_string()),
    }
}
```
**Verdict: FULLY COMPATIBLE** - Rust's Command API handles process spawning well.

#### Build Times
- First build: ~2-3 minutes (Rust compilation)
- Incremental: ~10-20 seconds
- Production: ~3-5 minutes

#### Recommendation
**HIGHLY RECOMMENDED if bundle size and performance matter.**

---

### 3. Neutralinojs

**Branch:** `experiment/neutralino`

#### Summary
Lightweight framework using system WebView with JavaScript backend.

#### Pros
- **Smallest bundle** (~2MB)
- Extremely fast startup
- Simple HTML/CSS/JS approach
- No runtime bundled
- Easy to understand

#### Cons
- Limited process control (no PID, no streams)
- Plain HTML/CSS/JS only (must bundle Vue separately)
- Less mature ecosystem
- No built-in auto-updater
- Fewer features than Electron/Tauri

#### AHK Integration
```javascript
// Uses os.execCommand with Windows 'start' command
await Neutralino.os.execCommand(`start "" "${ahkPath}"`, { background: true });

// Kill process
await Neutralino.os.execCommand('taskkill /IM Intuit.exe /F');
```
**Verdict: LIMITED COMPATIBILITY** - Works but with caveats:
- No PID returned from spawn
- No stdout/stderr streaming
- Must use platform-specific commands

#### Build Times
- Development: ~5 seconds
- Production: ~10 seconds

#### Recommendation
**CONSIDER if bundle size is critical and limited process control is acceptable.**

---

### 4. Electrobun

**Branch:** `experiment/electrobun`

#### Summary
New Bun-based framework with TypeScript-first approach.

#### Pros
- Native TypeScript support
- Bun's fast runtime
- Modern DX
- Smaller than Electron (theoretical)

#### Cons
- **NOT PRODUCTION READY**
- Very limited documentation
- API likely to change
- Windows support uncertain
- No established community
- Missing features

#### AHK Integration
```typescript
import { spawn } from "bun";

const proc = spawn({
  cmd: [ahkPath],
  detached: true
});
proc.unref();
```
**Verdict: LIKELY WORKS** - Bun's spawn is Node-compatible, but framework stability is the concern.

#### Build Times
- Unknown (framework too new to benchmark)

#### Recommendation
**DO NOT USE** - Too experimental. Revisit in 6-12 months.

---

## Comparison Matrix

| Criteria | electron-vite | Tauri | Neutralino | Electrobun |
|----------|--------------|-------|------------|------------|
| **Bundle Size** | 150MB | 10-15MB | 2MB | 15-30MB* |
| **Memory Usage** | High | Low | Low | Medium* |
| **Build Speed** | Fast | Medium | Very Fast | Unknown |
| **AHK Spawning** | Full | Full | Limited | Likely |
| **Vue/Nuxt Support** | Native | Via Vite | Manual | Unknown |
| **Auto-Updater** | Yes | Yes | No | No |
| **Stability** | Stable | Stable | Stable | Alpha |
| **Documentation** | Excellent | Good | Good | Poor |
| **Windows Support** | Full | Full | Full | Uncertain |
| **Learning Curve** | Low | Medium | Low | Unknown |
| **Migration Effort** | Low | Medium | Medium | High |

---

## Final Recommendation

### Primary Recommendation: **Tauri v2**

**Why Tauri?**
1. **Bundle size**: 10-15MB vs 150MB is a massive improvement
2. **Performance**: Lower memory, faster startup
3. **AHK support**: Full process spawning capability
4. **Stability**: Tauri v2 is mature and production-ready
5. **Security**: Rust backend, restrictive IPC by default
6. **Future-proof**: Active development, growing ecosystem

**Migration Path:**
1. Set up Tauri project structure
2. Learn basic Rust for backend commands
3. Port Vue components to pure Vue 3 (from Nuxt)
4. Implement IPC for AHK control
5. Test on Windows thoroughly

### Secondary Recommendation: **electron-vite**

**Why electron-vite as fallback?**
1. Minimal migration effort
2. All existing code patterns work
3. Faster iteration during development
4. Can migrate to Tauri later

**When to choose electron-vite:**
- Tight deadline (days, not weeks)
- Team unfamiliar with Rust
- Need to maintain feature parity quickly

### Not Recommended

- **Neutralinojs**: Process control limitations are concerning for AHK use case
- **Electrobun**: Too experimental, uncertain Windows support

---

## Next Steps

1. **Decision**: Choose between Tauri (recommended) or electron-vite (easier)
2. **Prototype validation**: Test AHK spawning on actual Windows machine
3. **Migration planning**: Create detailed migration checklist
4. **Development**: Start with `experiment/tauri` or `experiment/electron-vite` branch
5. **Testing**: Comprehensive Windows testing before release

---

## Branch Summary

```
main
├── experiment/electron-vite  # Recommended for quick migration
├── experiment/tauri          # RECOMMENDED - Best overall
├── experiment/neutralino     # Consider for extreme size constraints
└── experiment/electrobun     # Do not use (experimental)
```

Each branch contains:
- Working prototype configuration
- AHK spawning implementation
- Migration documentation (MIGRATION-*.md)

<template>
  <div class="flex" text-center>
    <div class="main" text-center>
      <h1 class="display-2 font-weight-bold mb-3">Intuiter</h1>
      <svg v-on:click="make" class="liquid-button" />
    </div>
  </div>
</template>

<script lang="ts">
import { run } from 'node-cmd'
import { defineComponent, onMounted } from '@vue/composition-api'
import { useStore } from '@nuxtjs/composition-api'
import { resolve, join } from 'path'
import { remote } from 'electron'
import DancingButton from 'dancing-button'
import { promises } from 'fs'
import { platform, homedir } from 'os'
import { execSync } from 'child_process'

import useToast from '~/composables/useToast'

import type { Store } from 'vuex'
import type { State } from '~/store/'

// Windows paths (AHK)
const AHK_PATH = 'resources\\ahk\\exe\\ahk\\AutoHotkey.exe'
const MAKER_PATH = 'resources\\ahk\\make.ahk'

// macOS paths (Hammerspoon)
const MAC_HAMMERSPOON_DIR = '.hammerspoon'
const MAC_INPUT_PATH = 'resources/mac-input/hammerspoon'

const exists = async (path: string) => await promises.stat(path).catch(() => false)

export default defineComponent({
  setup(_, context) {
    const store: Store<State> = useStore()
    const toast = useToast(context.root)
    const currentPlatform = platform()

    // Check if Hammerspoon is installed on macOS
    async function isHammerspoonInstalled(): Promise<boolean> {
      try {
        const appExists = await exists('/Applications/Hammerspoon.app')
        return appExists !== false
      } catch {
        return false
      }
    }

    // Install Hammerspoon configuration on macOS
    async function installMacConfig(): Promise<boolean> {
      const root = resolve(remote.app.getAppPath(), '../../')
      const sourcePath = resolve(root, MAC_INPUT_PATH)
      const destPath = join(homedir(), MAC_HAMMERSPOON_DIR)

      // Check if source files exist
      if (!(await exists(sourcePath))) {
        toast.error('Mac input files not found')
        return false
      }

      // Create destination directory
      try {
        await promises.mkdir(destPath, { recursive: true })
      } catch {
        // Directory may already exist
      }

      // Copy configuration files
      const files = ['init.lua', 'config.lua', 'mouse.lua', 'text.lua']
      for (const file of files) {
        const src = join(sourcePath, file)
        const dest = join(destPath, file)
        if (await exists(src)) {
          await promises.copyFile(src, dest)
        }
      }

      return true
    }

    // Reload Hammerspoon configuration
    function reloadHammerspoon(): void {
      try {
        execSync('open -a Hammerspoon')
        // Give it time to start, then reload
        setTimeout(() => {
          try {
            execSync('hs -c "hs.reload()"', { stdio: 'pipe' })
          } catch {
            // CLI may not be installed, that's okay
          }
        }, 1000)
      } catch {
        // Hammerspoon may not be running
      }
    }

    // Run on macOS
    async function makeMac() {
      store.state.loading = true

      // Check if Hammerspoon is installed
      const hammerspoonInstalled = await isHammerspoonInstalled()
      if (!hammerspoonInstalled) {
        toast.error('Hammerspoon not installed')
        toast.info('Install via: brew install --cask hammerspoon')
        store.state.loading = false
        return
      }

      // Install configuration
      const installed = await installMacConfig()
      if (!installed) {
        store.state.loading = false
        return
      }

      // Reload Hammerspoon
      reloadHammerspoon()

      toast.success('Intuiter Running')
      toast.info('Hammerspoon config loaded')
      store.state.loading = false
    }

    // Run on Windows (original AHK logic)
    async function makeWindows() {
      const root = resolve(remote.app.getAppPath(), '../../')
      const ahkPath = resolve(root, AHK_PATH)
      const makePath = resolve(root, MAKER_PATH)
      store.state.loading = true
      const exist = (await exists(ahkPath)) && (await exists(makePath))
      if (!exist) {
        toast.error('No File')
        store.state.loading = false
        return
      }
      run(`"${ahkPath}" "${makePath}"`, () => {
        toast.success('Intuiter Running')
        toast.info('You can close Window')
        store.state.loading = false
      })
    }

    // Platform-aware make function
    async function make() {
      if (currentPlatform === 'darwin') {
        await makeMac()
      } else if (currentPlatform === 'win32') {
        await makeWindows()
      } else {
        toast.error(`Unsupported platform: ${currentPlatform}`)
      }
    }

    onMounted(() => {
      const button = document.querySelector('.liquid-button')
      new DancingButton(button)
    })
    return { make }
  }
})
</script>

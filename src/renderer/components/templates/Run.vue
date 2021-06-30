<template>
  <div class="flex" text-center>
    <div class="main" text-center>
      <h1 class="display-2 font-weight-bold mb-3">Intuiter</h1>
      <v-btn v-on:click="make">Make and Run</v-btn>
    </div>
  </div>
</template>

<script lang="ts">
import { existsSync } from 'fs'
import { run } from 'node-cmd'
import { defineComponent } from '@vue/composition-api'
import { resolve } from 'path'
import { remote } from 'electron'

const AHK_PATH = 'resources\\ahk\\exe\\ahk\\AutoHotkey.exe'
const MAKER_PATH = 'resources\\ahk\\make.ahk'

export default defineComponent({
  setup() {
    const app = remote.app
    const current = remote.getCurrentWindow()

    // Run Command
    function make() {
      const root = resolve(app.getAppPath(), '../../')
      const ahkPath = resolve(root, AHK_PATH)
      const makePath = resolve(root, MAKER_PATH)
      if (!existsSync(ahkPath) || !existsSync(makePath)) return ifError('No Files')
      run(`"${ahkPath}" "${makePath}"`, afterMake)
    }

    // Close After run
    function afterMake(err: Error, data, stderr: string) {
      if (!err) return remote.app.exit(0)
      ifError(stderr)
    }

    // Error Dialog
    function ifError(stderr: string) {
      const options = { type: 'error', title: 'Error', message: 'Some Error Occured', detail: stderr }
      const dialog = remote.dialog
      dialog.showMessageBox(current, options)
    }

    return { make }
  }
})
</script>

<style scoped lang="postcss">
.flex {
  height: 100vh;
  display: flex;
}
.main {
  flex: 1 1 auto;
  margin-top: auto;
  margin-bottom: auto;
  padding-bottom: 10rem;
  text-align: center;
}
</style>

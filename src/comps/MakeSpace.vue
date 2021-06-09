<template>
  <v-container>
    <v-layout text-center wrap>
      <v-flex mb-4>
        <h1 class="display-2 font-weight-bold mb-3">Intuit Manager</h1>
        <v-btn v-on:click="make">Make and Run</v-btn>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import fs from 'fs'
import { remote } from 'electron'
import { get } from 'node-cmd'
import { resolve } from 'path'

export default {
  data: () => ({}),

  methods: {
    make() {
      const app = remote.app
      const root = resolve(app.getAppPath(), '../../')

      // Run Command
      let ahkPath = 'resources\\ahk\\exe\\ahk\\AutoHotkey.exe'
      let makePath = 'resources\\ahk\\make.ahk'
      if (!fs.existsSync(ahkPath)) {
        ahkPath = resolve(root, ahkPath)
        makePath = resolve(root, makePath)
      }
      get(`"${ahkPath}" "${makePath}"`, this.afterMake)
    },

    afterMake(err, data, stderr) {
      if (!err) {
        let win = remote.getCurrentWindow()
        win.close()
        return
      }
      this.ifError(err, data, stderr)
    },

    ifError(err, data, stderr) {
      const options = {
        type: 'error',
        title: 'Error',
        message: 'Some Error Occured',
        detail: stderr
      }
      const dialog = remote.dialog
      dialog.showMessageBox(null, options)
    }
  }
}
</script>

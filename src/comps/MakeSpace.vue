<template>
  <v-container>
    <v-layout text-center wrap>
      <v-flex class="mt-6">
        <h1 class="display-2 font-weight-bold mb-3">Intuiter</h1>
        <v-btn v-on:click="make">Make and Run</v-btn>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { existsSync } from 'fs'
import { get } from 'node-cmd'
import { defineComponent } from '@vue/composition-api'
import { resolve } from 'path'
import consola from 'consola'

const AHK_PATH = 'resources\\ahk\\exe\\ahk\\AutoHotkey.exe'
const MAKER_PATH = 'resources\\ahk\\make.ahk'

export default defineComponent({
  setup(props, context) {
    const electron = require('electron').app
    const remote = require('electron').remote
    const root = resolve(app.getAppPath(), '../../')

    // Run Command
    function make() {
      const ahkPath = resolve(root, AHK_PATH)
      const makePath = resolve(root, MAKER_PATH)
      if (!existsSync(ahkPath) || !existsSync(makePath)) return ifError('No Files')
      get(`"${ahkPath}" "${makePath}"`, afterMake)
    }

    // Close After run
    function afterMake(err, data, stderr) {
      if (!err) remote.getCurrentWindow().close()
      ifError(stderr)
    }

    // Error Dialog
    function ifError(stderr) {
      const options = { type: 'error', title: 'Error', message: 'Some Error Occured', detail: stderr }
      const dialog = remote.dialog
      dialog.showMessageBox(null, options)
    }
  }
})
</script>

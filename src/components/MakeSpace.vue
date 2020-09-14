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
import { dialog, remote } from 'electron'
import { get } from 'node-cmd'

export default {
  data: () => ({}),

  methods: {
    make() {
      let path = remote.app.getAppPath()
      console.log(path)
      // command run
      const ahkPath = 'resources\\ahk\\exe\\ahk\\AutoHotkey.exe'
      const makePath = 'resources\\ahk\\make.ahk'
      if (!fs.existsSync(path)) {
        const options = {
          type: 'error',
          title: 'Error',
          message: `${process.cwd()}`,
          detail: 'Reinstall or Contact to Developer Seonglae'
        }
        dialog.showMessageBox(null, options, (response) => {
          console.log(response)
        })
      }
      get(`"${ahkPath}" "${makePath}"`, this.after_make)
    },

    after_make(err, data, stderr) {
      if (!err) {
        let win = remote.getCurrentWindow()
        win.close()
        return
      }
      this.if_error(err, data, stderr)
    },

    if_error(err, data, stderr) {
      const options = {
        type: 'error',
        title: 'Error',
        message: 'Some Error Occured',
        detail: 'please press make button one more time'
      }
      dialog.showMessageBox(null, options, (response) => {
        console.log(response)
      })
      console.log('error', err, data, stderr)
    }
  }
}
</script>

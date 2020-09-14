<template>
  <v-app>
    <v-app-bar app style="-webkit-app-region: drag">
      <v-toolbar-title class="headline text-uppercase">
        <span>Intuiter - </span>
        <span class="font-weight-light">Intuit Manager</span>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn v-on:click="doc" class="mr-2">
        Doc
      </v-btn>
      <v-btn text v-on:click="close">
        Exit
      </v-btn>
    </v-app-bar>

    <v-main>
      <!-- <side-bar/> -->
      <make-space />
    </v-main>
  </v-app>
</template>

<script>
import MakeSpace from './components/MakeSpace'
import { shell } from 'electron'

export default {
  methods: {
    close() {
      const remote = require('electron').remote
      let win = remote.getCurrentWindow()
      win.close()
    },
    doc() {
      const url = 'https://github.com/sungle3737/intuiter'
      shell.openExternal(url)
    }
  },
  name: 'App',
  components: {
    MakeSpace
  }
}
</script>

<style>
::-webkit-scrollbar {
  display: none;
}
button {
  -webkit-app-region: no-drag;
}
</style>

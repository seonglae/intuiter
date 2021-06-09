<template>
  <v-app>
    <v-app-bar app style="-webkit-app-region: drag">
      <v-toolbar-title class="headline text-uppercase">
        <span>Intuiter - </span>
        <span class="font-weight-light">Intuit Manager</span>
      </v-toolbar-title>
      <v-spacer />
      <v-btn v-on:click="openDoc" class="mr-2">
        Doc
      </v-btn>
      <v-btn v-on:click="remote.getCurrentWindow().close" color="blue-grey darken-3">
        Exit
      </v-btn>
    </v-app-bar>
    <v-main>
      <make-space />
    </v-main>
  </v-app>
</template>

<script>
import MakeSpace from '../comps/MakeSpace'
import { defineComponent } from '@vue/composition-api'

const DOC = 'https://github.com/seonglae/intuiter'

export default defineComponent({
  name: 'index',
  components: { MakeSpace },
  setup() {
    const electron = require('electron')
    const { shell, remote } = electron
    const openDoc = () => shell.openExternal(DOC)
    return { openDoc, remote }
  }
})
</script>

<style>
::-webkit-scrollbar {
  display: none;
}
button {
  -webkit-app-region: no-drag;
}
</style>

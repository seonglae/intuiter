<template>
  <v-app
    style="
  border-radius: 10px;
  overflow: hidden;"
  >
    <v-app-bar app style="-webkit-app-region: drag;  border-radius: 10px; overflow: hidden;">
      <v-app-bar-title class="headline text-uppercase">
        <span>Intuit </span>
        <span class="font-weight-light">Manager</span>
      </v-app-bar-title>

      <v-tabs v-model="index" style="-webkit-app-region: no-drag">
        <v-spacer style="-webkit-app-region: drag" />
        <v-tab v-for="tab in tabs" :key="tab.type"> {{ tab.name }} </v-tab>
        <v-spacer style="-webkit-app-region: drag" />
      </v-tabs>

      <v-btn v-on:click="openDoc" class="mr-2">
        Doc
      </v-btn>
      <v-btn v-on:click="() => remote.app.exit(0)" color="blue-grey darken-3">
        Exit
      </v-btn>
    </v-app-bar>

    <v-main> </v-main>

    <v-tabs-items v-model="index" class="wrapper" style="background: #121213" touchless>
      <v-tab-item v-for="(tab, i) in tabs" :key="i" eager>
        <templates-run v-if="tab.key === 'home'" />
        <templates-opts v-else-if="tab.key === 'opt'" />
        <templates-shortcuts v-else-if="tab.key === 'shortcut'" />
        <templates-exts v-else-if="tab.key === 'ext'" />
      </v-tab-item>
    </v-tabs-items>
  </v-app>
</template>

<script lang="ts">
import { defineComponent, ref } from '@vue/composition-api'
import { shell, remote } from 'electron'

const DOC = 'https://github.com/seonglae/intuiter'

export default defineComponent({
  name: 'index',
  setup() {
    const openDoc = () => shell.openExternal(DOC)

    const tabs = [
      { name: 'Home', key: 'home' },
      { name: 'Option', key: 'opt' },
      { name: 'Shortcut', key: 'shortcut' },
      { name: 'Extension', key: 'ext' }
    ]
    const index = ref(0)
    return { openDoc, remote, tabs, index }
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

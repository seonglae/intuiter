<template>
  <v-app id="app">
    <v-app-bar app id="bar" class="top">
      <v-app-bar-title class="headline text-uppercase">
        <span>Intuit </span>
        <span class="font-weight-light">Manager</span>
      </v-app-bar-title>

      <v-tabs v-model="index" class="nodrag">
        <v-spacer class="drag" />
        <v-tab v-for="tab in tabs" :key="tab.type"> {{ tab.name }} </v-tab>
        <v-spacer class="drag" />
      </v-tabs>

      <v-btn v-on:click="github" class="mr-2">
        Github
      </v-btn>
      <v-btn v-on:click="() => remote.app.exit(0)" class="blue-grey darken-3">
        Exit
      </v-btn>
    </v-app-bar>

    <v-tabs-items v-model="index" class="wrapper bottom" id="view" touchless>
      <v-tab-item v-for="(tab, i) in tabs" :key="i" eager class="wrapper">
        <templates-run v-if="tab.key === 'home'" class="wrapper" />
      </v-tab-item>
    </v-tabs-items>
  </v-app>
</template>

<script lang="ts">
import { defineComponent, ref } from '@vue/composition-api'
import { shell, remote } from 'electron'
import pkg from '../../../package.json'

export default defineComponent({
  name: 'index',
  setup() {
    const github = () => shell.openExternal(pkg.repository)

    const tabs = [
      { name: 'Home', key: 'home' },
      { name: 'Option', key: 'opt' },
      { name: 'Shortcut', key: 'shortcut' },
      { name: 'Extension', key: 'ext' }
    ]
    const index = ref(0)

    return { github, remote, tabs, index }
  }
})
</script>

<style src="~/assets/toast.css" />

<script setup lang="ts">
import { ref, onMounted, nextTick } from 'vue'
import { invoke } from '@tauri-apps/api/core'
import { open } from '@tauri-apps/plugin-shell'
import { exit } from '@tauri-apps/plugin-process'
import DancingButton from 'dancing-button'

const index = ref(0)
const tabs = [
  { name: 'Home', key: 'home' },
  { name: 'Option', key: 'opt' },
  { name: 'Shortcut', key: 'shortcut' },
  { name: 'Extension', key: 'ext' },
  { name: 'Custom', key: 'custom' },
  { name: 'Document', key: 'docs' }
]

const loading = ref(false)
const digits = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
const customPaths = ref<string[]>(Array(10).fill(''))

onMounted(async () => {
  await nextTick()
  setTimeout(() => {
    const button = document.querySelector('.liquid-button') as SVGSVGElement
    if (button) {
      new DancingButton(button, {
        width: 200,
        height: 200,
        text: '▶'
      })
    }
  }, 100)
})

async function make() {
  loading.value = true
  try {
    await invoke('spawn_input')
  } catch (e) {
    console.error(e)
  }
  loading.value = false
}

async function github() {
  await open('https://github.com/seonglae/intuiter')
}

async function exitApp() {
  await exit(0)
}
</script>

<template>
  <v-app>
    <v-app-bar app id="bar" class="top">
      <v-app-bar-title class="headline text-uppercase">
        <span>Intuit </span>
        <span class="font-weight-light">Manager</span>
      </v-app-bar-title>

      <v-tabs v-model="index" class="nodrag">
        <v-spacer class="drag" />
        <v-tab v-for="tab in tabs" :key="tab.key">{{ tab.name }}</v-tab>
        <v-spacer class="drag" />
      </v-tabs>

      <v-btn @click="github" class="mr-2 nodrag">Github</v-btn>
      <v-btn @click="exitApp" color="blue-grey-darken-3" class="nodrag">Exit</v-btn>
    </v-app-bar>

    <v-window v-model="index" class="wrapper bottom" id="view">
      <!-- Home -->
      <v-window-item :value="0" class="wrapper">
        <div class="flex">
          <div class="main">
            <h1 class="display-2 font-weight-bold mb-3">Intuiter</h1>
            <svg @click="make" class="liquid-button" />
          </div>
        </div>
      </v-window-item>

      <!-- Option -->
      <v-window-item :value="1" class="wrapper">
        <div class="flex">
          <div class="main">
            <h1>Developing</h1>
          </div>
        </div>
      </v-window-item>

      <!-- Shortcut -->
      <v-window-item :value="2" class="wrapper">
        <div class="flex">
          <div class="main">
            <h1>Developing</h1>
          </div>
        </div>
      </v-window-item>

      <!-- Extension -->
      <v-window-item :value="3" class="wrapper">
        <div class="flex">
          <div class="main">
            <h1>Developing</h1>
          </div>
        </div>
      </v-window-item>

      <!-- Custom -->
      <v-window-item :value="4" class="wrapper">
        <div class="flex">
          <div class="main custom-main">
            <div v-for="(d, i) in digits" :key="d" class="mb-2">
              <v-text-field v-model="customPaths[i]" :label="`Cmd+${d}`" density="compact" variant="outlined" />
            </div>
            <v-btn color="primary">Save</v-btn>
          </div>
        </div>
      </v-window-item>

      <!-- Document -->
      <v-window-item :value="5" class="wrapper">
        <div class="flex docs-container">
          <iframe src="https://intuiter.vercel.app/en/usages/text.html" class="docs-iframe" />
        </div>
      </v-window-item>
    </v-window>

    <v-overlay :model-value="loading" class="loading-overlay">
      <v-progress-circular indeterminate size="64" />
    </v-overlay>
  </v-app>
</template>

<style>
::-webkit-scrollbar {
  display: none;
}

body {
  margin: 0 !important;
}

button {
  -webkit-app-region: no-drag;
}

.wrapper {
  height: 100%;
}

.flex {
  display: flex;
  height: 100%;
}

.top {
  flex: 1 0 auto;
}

.bottom {
  flex: 1 1 auto;
}

.drag {
  -webkit-app-region: drag;
}

.nodrag {
  -webkit-app-region: no-drag;
}

#view {
  background: #121314 !important;
}

#bar {
  -webkit-app-region: drag;
  border-radius: 10px;
  overflow: hidden;
}

.main {
  flex: 1 1 auto;
  margin-top: auto;
  margin-bottom: auto;
  text-align: center;
}

.liquid-button {
  width: 200px;
  height: 200px;
  cursor: pointer;
}

.docs-container {
  width: 100%;
  height: 100%;
}

.docs-iframe {
  width: 100%;
  height: 100%;
  border: none;
}

.loading-overlay {
  display: flex !important;
  align-items: center !important;
  justify-content: center !important;
}

.loading-overlay .v-overlay__content {
  position: static !important;
  display: flex !important;
  align-items: center !important;
  justify-content: center !important;
}

.custom-main {
  padding: 20px;
  max-width: 400px;
  margin: auto;
}
</style>

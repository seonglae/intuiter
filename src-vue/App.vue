<script setup lang="ts">
import { ref, onMounted, nextTick } from 'vue'
import { invoke } from '@tauri-apps/api/core'
import { open } from '@tauri-apps/plugin-shell'
import { exit } from '@tauri-apps/plugin-process'
import DancingButton from 'dancing-button'

const index = ref(0)
const tabs = [
  { name: 'HOME', key: 'home' },
  { name: 'OPTION', key: 'opt' },
  { name: 'SHORTCUT', key: 'shortcut' },
  { name: 'EXTENSION', key: 'ext' },
  { name: 'CUSTOM', key: 'custom' },
  { name: 'DOCUMENT', key: 'docs' }
]

const loading = ref(false)

onMounted(async () => {
  await nextTick()
  setTimeout(() => {
    const button = document.querySelector('.liquid-button')
    if (button) new DancingButton(button, {
      width: 200,
      height: 200,
      text: '▶',
      color1: '#4a5568',
      color2: '#2d3748',
      color3: '#1a202c'
    })
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
    <v-app-bar app id="bar" class="top drag">
      <v-app-bar-title class="headline text-uppercase nodrag">
        <span>Intuit </span>
        <span class="font-weight-light">Manager</span>
      </v-app-bar-title>

      <v-tabs v-model="index" class="nodrag">
        <v-spacer class="drag" />
        <v-tab v-for="tab in tabs" :key="tab.key">{{ tab.name }}</v-tab>
        <v-spacer class="drag" />
      </v-tabs>

      <v-btn variant="text" @click="github" class="mr-2 nodrag">GITHUB</v-btn>
      <v-btn variant="flat" color="blue-grey-darken-3" density="compact" @click="exitApp" class="mr-3 nodrag">EXIT</v-btn>
    </v-app-bar>

    <v-window v-model="index" class="wrapper bottom" id="view" touchless>
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
            <h2>OPTIONS</h2>
            <p>Application settings</p>
          </div>
        </div>
      </v-window-item>

      <!-- Shortcut -->
      <v-window-item :value="2" class="wrapper">
        <div class="flex">
          <div class="main">
            <h2>SHORTCUTS</h2>
            <p>Caps Lock + H/J/K/L = Arrow keys</p>
            <p>Caps Lock + U/I/O/P = Mouse control</p>
          </div>
        </div>
      </v-window-item>

      <!-- Extension -->
      <v-window-item :value="3" class="wrapper">
        <div class="flex">
          <div class="main">
            <h2>EXTENSIONS</h2>
            <p>Script extensions</p>
          </div>
        </div>
      </v-window-item>

      <!-- Custom -->
      <v-window-item :value="4" class="wrapper">
        <div class="flex">
          <div class="main">
            <h2>CUSTOM</h2>
            <p>Custom configurations</p>
          </div>
        </div>
      </v-window-item>

      <!-- Document -->
      <v-window-item :value="5" class="wrapper docs-wrapper">
        <iframe src="https://intuiter.vercel.app/en/usages/text.html" class="docs-iframe" />
      </v-window-item>
    </v-window>

    <v-overlay :model-value="loading" contained class="loading-overlay">
      <v-progress-circular indeterminate size="64" />
    </v-overlay>
  </v-app>
</template>

<style>
::-webkit-scrollbar {
  display: none;
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
  border-radius: 10px 10px 0 0;
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

.docs-wrapper {
  display: flex;
  flex-direction: column;
}

.docs-iframe {
  flex: 1;
  width: 100%;
  height: 100%;
  border: none;
}

.v-btn {
  text-transform: none !important;
}

.v-tab {
  text-transform: none !important;
}

.loading-overlay {
  display: flex;
  align-items: center;
  justify-content: center;
}

.loading-overlay .v-overlay__content {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
}
</style>

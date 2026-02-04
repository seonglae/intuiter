<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { invoke } from '@tauri-apps/api/core'

// Tab navigation
const currentTab = ref('run')

const tabs = [
  { id: 'run', title: 'Run', icon: 'mdi-play' },
  { id: 'shortcuts', title: 'Shortcuts', icon: 'mdi-keyboard' },
  { id: 'options', title: 'Options', icon: 'mdi-cog' },
  { id: 'extensions', title: 'Extensions', icon: 'mdi-puzzle' },
  { id: 'docs', title: 'Docs', icon: 'mdi-book-open-variant' }
]

const ahkStatus = ref<'running' | 'stopped' | 'unknown'>('unknown')
const statusMessage = ref('')

// Check AHK status on mount
onMounted(async () => {
  await checkStatus()
})

async function checkStatus() {
  try {
    const isRunning = await invoke<boolean>('check_ahk_status')
    ahkStatus.value = isRunning ? 'running' : 'stopped'
  } catch (e) {
    console.error('Failed to check status:', e)
    ahkStatus.value = 'unknown'
  }
}

async function startAHK() {
  try {
    statusMessage.value = 'Starting AHK...'
    const result = await invoke<string>('spawn_ahk')
    statusMessage.value = result
    ahkStatus.value = 'running'
  } catch (e: any) {
    statusMessage.value = `Error: ${e}`
    console.error('Failed to start AHK:', e)
  }
}

async function stopAHK() {
  try {
    statusMessage.value = 'Stopping AHK...'
    const result = await invoke<string>('kill_ahk')
    statusMessage.value = result
    ahkStatus.value = 'stopped'
  } catch (e: any) {
    statusMessage.value = `Error: ${e}`
    console.error('Failed to stop AHK:', e)
  }
}

async function restartAHK() {
  try {
    statusMessage.value = 'Restarting AHK...'
    const result = await invoke<string>('restart_ahk')
    statusMessage.value = result
    ahkStatus.value = 'running'
  } catch (e: any) {
    statusMessage.value = `Error: ${e}`
    console.error('Failed to restart AHK:', e)
  }
}
</script>

<template>
  <v-app>
    <v-app-bar flat color="transparent" density="compact" data-tauri-drag-region>
      <v-app-bar-title>Intuiter (Tauri)</v-app-bar-title>
      <v-chip
        :color="ahkStatus === 'running' ? 'success' : ahkStatus === 'stopped' ? 'error' : 'grey'"
        size="small"
        class="mr-4"
      >
        AHK: {{ ahkStatus }}
      </v-chip>
    </v-app-bar>

    <v-navigation-drawer permanent rail>
      <v-list density="compact" nav>
        <v-list-item
          v-for="tab in tabs"
          :key="tab.id"
          :prepend-icon="tab.icon"
          :title="tab.title"
          :active="currentTab === tab.id"
          @click="currentTab = tab.id"
        />
      </v-list>
    </v-navigation-drawer>

    <v-main>
      <v-container fluid>
        <!-- Run Tab -->
        <div v-if="currentTab === 'run'">
          <h2 class="text-h5 mb-4">Run AHK</h2>
          <v-card class="mb-4">
            <v-card-text>
              <p class="mb-4">Control the AutoHotkey process that handles keyboard shortcuts.</p>
              <v-btn color="success" class="mr-2" @click="startAHK">
                <v-icon start>mdi-play</v-icon>
                Start AHK
              </v-btn>
              <v-btn color="error" class="mr-2" @click="stopAHK">
                <v-icon start>mdi-stop</v-icon>
                Stop AHK
              </v-btn>
              <v-btn color="warning" @click="restartAHK">
                <v-icon start>mdi-restart</v-icon>
                Restart AHK
              </v-btn>
            </v-card-text>
          </v-card>

          <v-alert v-if="statusMessage" type="info" class="mb-4">
            {{ statusMessage }}
          </v-alert>

          <v-card>
            <v-card-title>Tauri Benefits</v-card-title>
            <v-card-text>
              <v-list>
                <v-list-item prepend-icon="mdi-memory">
                  <v-list-item-title>~10MB bundle size</v-list-item-title>
                  <v-list-item-subtitle>vs ~150MB with Electron</v-list-item-subtitle>
                </v-list-item>
                <v-list-item prepend-icon="mdi-speedometer">
                  <v-list-item-title>Lower memory usage</v-list-item-title>
                  <v-list-item-subtitle>Uses system WebView</v-list-item-subtitle>
                </v-list-item>
                <v-list-item prepend-icon="mdi-language-rust">
                  <v-list-item-title>Rust backend</v-list-item-title>
                  <v-list-item-subtitle>Type-safe, fast, secure</v-list-item-subtitle>
                </v-list-item>
              </v-list>
            </v-card-text>
          </v-card>
        </div>

        <!-- Shortcuts Tab -->
        <div v-else-if="currentTab === 'shortcuts'">
          <h2 class="text-h5 mb-4">Keyboard Shortcuts</h2>
          <v-card>
            <v-card-text>
              <p>Configure your keyboard shortcuts here.</p>
              <p class="text-grey mt-2">(Tauri prototype - AHK spawning works via Rust Command API)</p>
            </v-card-text>
          </v-card>
        </div>

        <!-- Options Tab -->
        <div v-else-if="currentTab === 'options'">
          <h2 class="text-h5 mb-4">Options</h2>
          <v-card>
            <v-card-text>
              <p>Application settings and preferences.</p>
            </v-card-text>
          </v-card>
        </div>

        <!-- Extensions Tab -->
        <div v-else-if="currentTab === 'extensions'">
          <h2 class="text-h5 mb-4">Extensions</h2>
          <v-card>
            <v-card-text>
              <p>Manage AHK script extensions.</p>
            </v-card-text>
          </v-card>
        </div>

        <!-- Docs Tab -->
        <div v-else-if="currentTab === 'docs'">
          <h2 class="text-h5 mb-4">Documentation</h2>
          <v-card>
            <v-card-text>
              <p>Intuiter documentation and help.</p>
            </v-card-text>
          </v-card>
        </div>
      </v-container>
    </v-main>
  </v-app>
</template>

<style>
html, body, #app {
  height: 100%;
  margin: 0;
  overflow: hidden;
}

/* Allow dragging on title bar */
[data-tauri-drag-region] {
  -webkit-app-region: drag;
}

[data-tauri-drag-region] * {
  -webkit-app-region: no-drag;
}
</style>

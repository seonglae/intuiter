<script setup lang="ts">
import { ref, onMounted } from 'vue'

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

// Check if we have access to electron APIs
const hasElectronAPI = ref(false)

onMounted(() => {
  hasElectronAPI.value = typeof window !== 'undefined' && 'api' in window
})

async function startAHK() {
  if (hasElectronAPI.value) {
    try {
      // @ts-ignore
      await window.api.spawnAHK()
      ahkStatus.value = 'running'
    } catch (e) {
      console.error('Failed to start AHK:', e)
    }
  }
}

async function stopAHK() {
  if (hasElectronAPI.value) {
    try {
      // @ts-ignore
      await window.api.killAHK()
      ahkStatus.value = 'stopped'
    } catch (e) {
      console.error('Failed to stop AHK:', e)
    }
  }
}
</script>

<template>
  <v-app>
    <v-app-bar flat color="transparent" density="compact" style="-webkit-app-region: drag">
      <v-app-bar-title>Intuiter</v-app-bar-title>
      <v-chip
        :color="ahkStatus === 'running' ? 'success' : ahkStatus === 'stopped' ? 'error' : 'grey'"
        size="small"
        class="mr-4"
        style="-webkit-app-region: no-drag"
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
          <v-card>
            <v-card-text>
              <p class="mb-4">Control the AutoHotkey process that handles keyboard shortcuts.</p>
              <v-btn color="success" class="mr-2" @click="startAHK">
                <v-icon start>mdi-play</v-icon>
                Start AHK
              </v-btn>
              <v-btn color="error" @click="stopAHK">
                <v-icon start>mdi-stop</v-icon>
                Stop AHK
              </v-btn>
            </v-card-text>
          </v-card>
        </div>

        <!-- Shortcuts Tab -->
        <div v-else-if="currentTab === 'shortcuts'">
          <h2 class="text-h5 mb-4">Keyboard Shortcuts</h2>
          <v-card>
            <v-card-text>
              <p>Configure your keyboard shortcuts here.</p>
              <p class="text-grey mt-2">(Migrated from electron-nuxt to electron-vite)</p>
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
</style>

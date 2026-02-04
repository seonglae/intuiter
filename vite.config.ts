import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vuetify from 'vite-plugin-vuetify'
import { resolve } from 'path'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    vuetify({ autoImport: true })
  ],
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src-vue')
    }
  },
  root: '.',
  build: {
    outDir: 'dist'
  },
  // Vite options for Tauri development
  clearScreen: false,
  server: {
    port: 5173,
    strictPort: true
  },
  envPrefix: ['VITE_', 'TAURI_']
})

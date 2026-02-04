import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { resolve } from 'path'

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src-react')
    }
  },
  root: '.',
  build: {
    outDir: 'dist'
  },
  clearScreen: false,
  server: {
    port: 5173,
    strictPort: true
  },
  envPrefix: ['VITE_', 'TAURI_']
})

'use strict'

import { app, protocol, BrowserWindow } from 'electron'
import { createProtocol } from 'vue-cli-plugin-electron-builder/lib'
const isDevelopment = process.env.NODE_ENV !== 'production'

let win

// Scheme must be registered before the app is ready
protocol.registerSchemesAsPrivileged([
  { scheme: 'app', privileges: { secure: true, standard: true } }
])

function createWindow() {
  win = new BrowserWindow({
    width: 850,
    height: 500,
    minWidth: 850,
    minHeight: 500,
    transparent: true,
    frame: false,
    titleBarStyle: 'hiddenInset',
    webPreferences: {
      nodeIntegration: true
    }
  })
  if (process.env.WEBPACK_DEV_SERVER_URL) {
    win.loadURL(process.env.WEBPACK_DEV_SERVER_URL)
    if (!process.env.IS_TEST) win.webContents.openDevTools()
  } else {
    createProtocol('app')
    win.loadURL('app://./index.html')
  }
  win.on('closed', () => (win = null))
  win.setMenu(null)
}

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit()
})

app.on('activate', () => {
  if (win === null) createWindow()
})
app.on('ready', async () => createWindow())

// Exit cleanly on request from parent process in development mode.
if (isDevelopment)
  if (process.platform === 'win32')
    process.on('message', (data) => {
      if (data === 'graceful-exit') app.quit()
    })
  else process.on('SIGTERM', () => app.quit())

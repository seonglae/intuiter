import { app, protocol, BrowserWindow } from 'electron'
import { createProtocol } from 'vue-cli-plugin-electron-builder/lib'

let win
const isDevelopment = process.env.NODE_ENV !== 'production'
if (isDevelopment)
  if (process.platform === 'win32') process.on('message', data => (data === 'graceful-exit' ? app.quit() : null))
  else process.on('SIGTERM', () => app.quit())

app.on('window-all-closed', () => (process.platform !== 'darwin' ? app.quit() : null))
app.on('activate', () => (win === null ? createWindow() : null))
app.on('ready', async () => createWindow())
protocol.registerSchemesAsPrivileged([{ scheme: 'app', privileges: { secure: true, standard: true } }])

function createWindow() {
  win = new BrowserWindow({
    width: 850,
    height: 500,
    minWidth: 850,
    minHeight: 500,
    transparent: true,
    frame: false,
    titleBarStyle: 'hiddenInset',
    webPreferences: { nodeIntegration: true, contextIsolation: false }
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

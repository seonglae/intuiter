import { app, BrowserWindow, shell } from 'electron'
import { spawn } from 'child_process'
import { join, dirname } from 'path'
import { existsSync } from 'fs'
import { electronApp, optimizer, is } from '@electron-toolkit/utils'

let mainWindow: BrowserWindow | null = null

function createWindow(): void {
  mainWindow = new BrowserWindow({
    width: 1000,
    height: 600,
    minWidth: 1000,
    minHeight: 600,
    transparent: true,
    frame: false,
    titleBarStyle: 'hiddenInset',
    webPreferences: {
      preload: join(__dirname, '../preload/index.js'),
      sandbox: false
    }
  })

  mainWindow.on('ready-to-show', () => {
    mainWindow?.show()
  })

  mainWindow.webContents.setWindowOpenHandler((details) => {
    shell.openExternal(details.url)
    return { action: 'deny' }
  })

  // Load the renderer
  if (is.dev && process.env['ELECTRON_RENDERER_URL']) {
    mainWindow.loadURL(process.env['ELECTRON_RENDERER_URL'])
  } else {
    mainWindow.loadFile(join(__dirname, '../renderer/index.html'))
  }
}

// AHK Process spawning - critical functionality
function spawnAHKProcess(): void {
  // Path to AHK executable (compiled or script)
  const ahkExePath = is.dev
    ? join(__dirname, '../../packages/ahk/Intuit.exe')
    : join(process.resourcesPath, 'ahk', 'Intuit.exe')

  if (existsSync(ahkExePath)) {
    console.log('Starting AHK process:', ahkExePath)
    const ahkProcess = spawn(ahkExePath, [], {
      detached: true,
      stdio: 'ignore',
      cwd: dirname(ahkExePath)
    })
    ahkProcess.unref()
    console.log('AHK process spawned successfully')
  } else {
    console.warn('AHK executable not found at:', ahkExePath)
  }
}

app.whenReady().then(() => {
  electronApp.setAppUserModelId('com.intuiter')

  app.on('browser-window-created', (_, window) => {
    optimizer.watchWindowShortcuts(window)
  })

  createWindow()

  // Spawn AHK on Windows
  if (process.platform === 'win32') {
    spawnAHKProcess()
  }

  app.on('activate', function () {
    if (BrowserWindow.getAllWindows().length === 0) createWindow()
  })
})

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit()
  }
})

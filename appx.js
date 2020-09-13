const convertToWindowsStore = require('electron-windows-store')

convertToWindowsStore({
  containerVirtualization: false,
  inputDirectory: 'dist',
  outputDirectory: 'appx',
  packageName: 'Intuiter',
  packageDisplayName: 'Intuiter',
  packageDescription: 'Intuiter',
  packageExecutable: 'app/intuiter.exe',
  manifest: 'AppXManifest.xml'
})

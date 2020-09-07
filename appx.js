const convertToWindowsStore = require('electron-windows-store')

convertToWindowsStore({
  containerVirtualization: false,
  inputDirectory: 'dist',
  outputDirectory: 'appx',
  packageVersion: '0.5.0.1',
  packageName: 'Intuiter',
  packageDisplayName: 'Intuiter Desktop',
  packageDescription: 'Intuiter for Desktops',
  packageExecutable: 'app/intuiter.exe',
  manifest: 'AppXManifest.xml',
  publisher: 'CN=developmentca',
})
const convertToWindowsStore = require('electron-windows-store')

convertToWindowsStore({
  containerVirtualization: false,
  inputDirectory: 'dist',
  outputDirectory: 'appx',
  packageName: 'Intuiter',
  packageDisplayName: 'Intuiter',
  packageDescription: 'Intuiter',
  manifest: 'AppXManifest.xml',
  publisher: 'CN=developmentca'
})

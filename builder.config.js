require('dotenv').config()

const ICONS_DIR = 'build/icons/'

const windowsOS = {
  win: {
    icon: ICONS_DIR + 'white.ico',
    requestedExecutionLevel: 'highestAvailable',
    target: 'nsis',
    certificateFile: 'Seonglae.pfx',
    certificatePassword: process.env.PASS,
    rfc3161TimeStampServer: 'http://timestamp.globalsign.com/scripts/timstamp.dll'
  },
  nsis: { differentialPackage: true, include: 'src/nsis/remove_startup.nsh' }
}

module.exports = {
  asar: false,
  productName: 'Intuiter',
  appId: 'com.seonglae.intuiter',
  artifactName: 'Intuiter-${version}.${ext}',
  directories: {
    output: 'build'
  },
  extraResources: [{ from: './resources/ahk/', to: 'ahk' }],
  files: [
    'package.json',
    {
      from: 'dist/main/',
      to: 'dist/main/'
    },
    {
      from: 'dist/renderer',
      to: 'dist/renderer/'
    }
  ],
  ...windowsOS
}

const ICONS_DIR = 'src/resources/image/'

const windowsOS = {
  win: {
    icon: ICONS_DIR + 'white.ico',
    requestedExecutionLevel: 'highestAvailable',
    publisherName: 'seonglae',
    target: ['nsis'],
  },
  nsis: { differentialPackage: true, include: 'src/nsis/remove_startup.nsh' },
}

module.exports = {
  asar: false,
  productName: 'Intuiter',
  appId: 'com.seonglae.intuiter',
  artifactName: 'my-browser-${version}.${ext}',
  directories: {
    output: 'build',
  },
  extraResources: [{ from: './src/resources/ahk/', to: 'ahk' }],
  files: [
    'package.json',
    {
      from: 'dist/main/',
      to: 'dist/main/',
    },
    {
      from: 'dist/renderer',
      to: 'dist/renderer/',
    },
    {
      from: 'src/resources/',
      to: 'dist/resources/',
    },
  ],
  ...windowsOS,
}
F

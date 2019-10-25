module.exports = {
  transpileDependencies: [
    'vuetify'
  ],
  configureWebpack:{
    performance: {
      hints: false
    },
    optimization: {
      splitChunks: {
        minSize: 10000,
        maxSize: 250000,
      }
    }
  },
  pluginOptions: {
    electronBuilder: {
      builderOptions: {
        extraResources: [
          {
            from: './resources/ahk/',
            to: 'ahk',
            filter: [
              '**/*'
            ]
          }
        ],
        nsis: {
          deleteAppDataOnUninstall: true,
          createDesktopShortcut: true,
          include: 'dist_electron/nsis/remove_startup.nsh'
        },
        appx: {
          identityName: 'sungleCho.Intuiter',
          applicationId: 'Intuiter',
          publisher: 'CN=169E7280-3382-426D-AE3B-5FB3786A703F',
          publisherDisplayName: 'seonglae'
        },
        productName: 'Intuiter',
        appId: 'com.seonglae.intuiter',
        directories: {
          output: 'dist_electron'
        },
        win: {
          target: [
            'nsis',
            'appx'
          ],
          requestedExecutionLevel: 'highestAvailable',
          certificateFile: 'dist_electron/Seonglae.pfx',
          certificatePassword: 'sung1103215!',
          icon: 'dist_electron/icons/icon.ico',
          certificateSubjectName: 'CN=developmentca',
          rfc3161TimeStampServer: 'http://timestamp.globalsign.com/scripts/timstamp.dll'
        }
      }
    }
  }
}

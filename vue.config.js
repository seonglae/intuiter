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
        maxSize: 200000,
      }
    }
  },
  pluginOptions: {
    electronBuilder: {
      builderOptions: {
        extraResources: [
          {
            from: './resources/ahk/',
            to: 'ahk'
          }
        ],
        nsis: {
          include: 'dist/nsis/remove_startup.nsh',
        },
        appx: {
          identityName: 'sungleCho.Intuiter',
          applicationId: 'Intuiter',
          publisher: 'CN=169E7280-3382-426D-AE3B-5FB3786A703F',
          publisherDisplayName: 'seonglae',
        },
        productName: 'Intuiter',
        appId: 'com.seonglae.intuiter',
        directories: {
          output: 'dist'
        },
        win: {
          target: [
            'nsis',
            'appx'
          ],
          requestedExecutionLevel: 'highestAvailable',
          certificateFile: 'dist/Seonglae.pfx',
          certificatePassword: 'sung1103215!',
          icon: 'dist/icons/icon.ico',
          certificateSubjectName: 'CN=developmentca',
          rfc3161TimeStampServer: 'http://timestamp.globalsign.com/scripts/timstamp.dll'
        }
      }
    }
  }
}

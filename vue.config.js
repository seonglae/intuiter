require('dotenv').config()

module.exports = {
  transpileDependencies: ['vuetify'],
  configureWebpack: {
    performance: {
      hints: false
    },
    optimization: {
      splitChunks: {
        minSize: 10000,
        maxSize: 200000
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
          },
          {
            from: './gif/',
            to: 'gif'
          }
        ],
        nsis: {
          include: 'nsis/remove_startup.nsh'
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
          output: 'dist'
        },
        win: {
          target: [
            'nsis'
            // 'appx'
          ],
          requestedExecutionLevel: 'highestAvailable',
          // certificateFile: 'Seonglae.pfx',
          // certificatePassword: process.env.PASS,
          icon: 'gif/white.png',
          // certificateSubjectName: 'CN=developmentca',
          rfc3161TimeStampServer:
            'http://timestamp.globalsign.com/scripts/timstamp.dll'
        }
      }
    }
  }
}

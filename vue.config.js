module.exports = {
  "transpileDependencies": [
    "vuetify"
  ],
  pluginOptions: {
    electronBuilder: {
      builderOptions: {
        "extraResources": [
          {
            "from": "./resources/ahk/",
            "to": "ahk",
            "filter": [
              "**/*"
            ]
          }
        ],
        "nsis": {
          "deleteAppDataOnUninstall": true,
          "createDesktopShortcut": true,
        },
        "appx": {
          "identityName": "sungleCho.Intuiter",
          "applicationId": "Intuiter",
          "publisher": "CN=169E7280-3382-426D-AE3B-5FB3786A703F",
          "publisherDisplayName": "seonglae"
        },
        "productName": "Intuiter",
        "appId": "com.seonglae.intuiter",
        "directories": {
          "output": "dist_electron"
        },
        "win": {
          "target": [
            "nsis",
            "appx"
          ],
          "requestedExecutionLevel": "highestAvailable",
          "certificateFile" : "dist_electron/intuiter.pfx",
          "certificatePassword" : "sung1103215!",
          "icon": "dist_electron/icons/icon.ico",
          "publisherName" : "Seonglae",
          "certificateSubjectName" : "Seonglae"
        }
      }
    }
  }
}
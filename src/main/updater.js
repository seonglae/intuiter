import { app, dialog, autoUpdater } from 'electron'

const server = 'https://update.electronjs.org'
const feed = `${server}/seonglae/intuiter/${process.platform}-${process.arch}/${app.getVersion()}`
autoUpdater.setFeedURL({ url: feed })

app.whenReady().then(() => {
  autoUpdater.checkForUpdates()
})

autoUpdater.on('update-downloaded', () => {
  const result = dialog.showMessageBoxSync({
    type: 'question',
    buttons: ['Restart', 'Later'],
    defaultId: 0,
    message: 'A new update is ready. Restart to install now?'
  })
  if (result === 0) autoUpdater.quitAndInstall()
})

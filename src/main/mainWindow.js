import BrowserWinHandler from './BrowserWinHandler'

const winHandler = new BrowserWinHandler({
  width: 1000,
  height: 600,
  minWidth: 1000,
  minHeight: 600,
  transparent: true,
  frame: false,
  titleBarStyle: 'hiddenInset',
  webPreferences: {
    enableRemoteModule: true
  }
})

winHandler.onCreated(_browserWindow => winHandler.loadPage('/'))

export default winHandler

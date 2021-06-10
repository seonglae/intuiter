import BrowserWinHandler from './BrowserWinHandler'

const winHandler = new BrowserWinHandler({
  width: 850,
  height: 500,
  minWidth: 850,
  minHeight: 500,
  transparent: true,
  frame: false,
  titleBarStyle: 'hiddenInset',
  webPreferences: {
    enableRemoteModule: true
  }
})

winHandler.onCreated(_browserWindow => winHandler.loadPage('/'))

export default winHandler

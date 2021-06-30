const { RESOURCES_DIR } = require('./config')

const RESOURCES_DIR_PATH = RESOURCES_DIR.replace(/\\/g, '/')
const isProduction = process.env.NODE_ENV === 'production'

function devPath() {
  return `'${RESOURCES_DIR_PATH}'`
}

function productionPath() {
  return `process.resourcesPath`
}

module.exports = {
  mainProcess() {
    return isProduction ? productionPath() : devPath()
  },
  nuxtClient() {
    return isProduction ? productionPath() : devPath()
  },
  nuxtServer: devPath
}

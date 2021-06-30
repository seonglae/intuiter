/*
  This module cannot contain any external libraries!
 */

const { engines } = require('../package')

const RESET = '\x1b[0m'
const FG_RED = '\x1b[31m'

function checkNodeVersion() {
  if (engines.node === undefined) return
  const requiredMinVersion = engines.node.replace(/[=<>]/g, '')
  const installedVersion = process.versions.node
  if (compare(requiredMinVersion, installedVersion) === 1) {
    console.log(FG_RED)
    console.log(`\tYou are running version v${installedVersion} of Node.js, which is not supported by Electron-nuxt.`)
    console.log(`\tThe official Node.js version that is supported is ${requiredMinVersion} or greater.`)
    console.log(RESET)
    console.log('\n\tPlease visit https://nodejs.org/en/ to find instructions on how to update Node.js.\n')
    throw new Error('Invalid node version')
  }
}

function disallowNpm() {
  const execPath = process.env.npm_execpath
  if (!execPath.includes('yarn')) {
    console.log(FG_RED)
    console.log(`\tElectron-nuxt supports only Yarn package manager.`)
    console.log(RESET)
    console.log('\n\tPlease visit https://legacy.yarnpkg.com/en/docs/install to find instructions on how to install Yarn.\n')
    throw new Error('Invalid package manager')
  }
}

function compare(a, b) {
  if (a === b) return 0
  const a_components = a.split('.')
  const b_components = b.split('.')
  const len = Math.min(a_components.length, b_components.length)
  for (let i = 0; i < len; i++) {
    if (parseInt(a_components[i]) > parseInt(b_components[i])) return 1
    if (parseInt(a_components[i]) < parseInt(b_components[i])) return -1
  }
  if (a_components.length > b_components.length) return 1
  if (a_components.length < b_components.length) return -1
  return 0
}

try {
  checkNodeVersion()
  disallowNpm()
  if (require.main === module) process.exit(0)
} catch (e) {
  process.exit(1)
}

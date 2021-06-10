/* eslint-disable */
import { app, protocol } from 'electron'
import * as path from 'path'
import { URL } from 'url'

const PRODUCTION_APP_PROTOCOL = 'app'
const PRODUCTION_APP_PATH = path.join(__dirname, '..', 'renderer')

protocol.registerSchemesAsPrivileged([{ scheme: PRODUCTION_APP_PROTOCOL, privileges: { secure: true, standard: true } }])

app.once('ready', () => registerProtocol(PRODUCTION_APP_PROTOCOL))

function registerProtocol(scheme) {
  protocol.registerFileProtocol(scheme, (request, callback) => {
    const relativePath = path.normalize(new URL(request.url).pathname)
    const absolutePath = path.join(PRODUCTION_APP_PATH, relativePath)
    callback({ path: absolutePath })
  })
}

require('../index')

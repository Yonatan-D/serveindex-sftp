const express    = require('express')
const serveIndex = require('serve-index')
const { port=80, user='test', dir='upload' } = require('minimist')(process.argv.slice(2))

const app = express()

const index = serveIndex(`/home/${user}/${dir}`, {'icons': true,'view':'details'})

const serve = express.static(`/home/${user}/${dir}`)

app.use('/', serve, index)

app.listen(port, () => {
    console.log(`[serverIndex](/home/${user}/${dir}) listening at http://localhost:${port}`)
})

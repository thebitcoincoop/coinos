var merge = require('webpack-merge')
var prodEnv = require('./prod.env')

module.exports = merge(prodEnv, {
  NODE_ENV: '"development"',
  GRAPHQL: '"http://localhost:3000/graphql"',
  SOCKETIO: '"coinos.io:3000"',
})

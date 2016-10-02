db = require('../redis')
db.keys('user:*', (err, obj) ->
  for user in obj
    db.rename(user, user.toLowerCase()) unless user is user.toLowerCase()
)

db.keys('*:transactions', (err, obj) ->
  for user in obj
    db.rename(user, user.toLowerCase()) unless user is user.toLowerCase()
)

console.log('All done!')
process.exit()

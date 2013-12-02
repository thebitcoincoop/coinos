sequelize = require('../sequelize')

module.exports =
  json: (req, res) ->
    user = req.params.user
    sequelize.query('SELECT * FROM orders').success((rows) ->
      res.write(JSON.stringify(rows))
    )
    res.end()

  create: (req, res) ->
    user = req.params.user

  index: (req, res) ->
    res.render('transactions/index',  
      user: req.params.user,
      js: (-> global.js), 
      css: (-> global.css)
    )


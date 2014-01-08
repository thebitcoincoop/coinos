db = require('../models')
bcrypt = require('bcrypt')

module.exports = (sessions) ->
  exists: (req, res) ->
    db.hgetall("user:"+req.params.user, (err, obj) ->
      if obj? then res.write('true') else res.write('false')
      res.end()
    )
  
  json: (req, res) ->
    db.hgetall("user:"+req.params.user, (err, obj) ->
      delete obj['password']
      res.write(JSON.stringify(obj))
      res.end()
    )

  index: (req, res) -> 
    db.keys('*', (err, obj) ->
      res.write(JSON.stringify(obj))
      res.end()
    )

  list: (req, res) ->
    res.render('users/index', 
      js: (-> global.js), 
      css: (-> global.css),
      layout: 'layout'
    )

  show: (req, res) ->
    db.hgetall("user:"+req.params.user, (err, obj) ->
      delete obj['password']
      obj.string = JSON.stringify(obj)
      res.render('users/show', 
        user: obj,
        js: (-> global.js), 
        css: (-> global.css) 
      )
    )

  dashboard: (req, res) ->
    db.hgetall("user:"+req.params.user, (err, obj) ->
      delete obj['password']
      res.render('users/dashboard', 
        user: JSON.stringify(obj),
        js: (-> global.js), 
        css: (-> global.css),
        layout: 'layout'
      )
    )

  new: (req, res) ->
    res.render('users/new', 
      js: (-> global.js), 
      css: (-> global.css)
    )     

  create: (req, res) ->
    userkey = "user:"+req.body.username
    db.hgetall(userkey, (err, obj) ->
      if obj
        res.redirect("/#{req.body.username}/edit")
      else
        bcrypt.hash(req.body.password, 12, (err, hash) ->
           db.sadd("users",userkey)
           db.hmset(userkey,
             username: req.body.username,
             password: hash,
             email: req.body.email
            , ->
              req.headers['referer'] = "/#{req.body.username}/edit"
              sessions.create(req, res)
           )
        )
    )

  edit: (req, res) ->
    db.hgetall("user:"+req.params.user, (err, obj) ->
      delete obj['password']
      res.render('users/edit', 
        user: JSON.stringify(obj),
        js: (-> global.js), 
        css: (-> global.css),
        layout: 'layout'
      )
    )

  update: (req, res) ->
    return unless req.params.user is req.user.username or 
    req.user.username is 'admin'
    db.hmset("user:"+req.params.user, req.body, ->
      res.redirect("/#{req.params.user}")
    )

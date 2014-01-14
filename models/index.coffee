fs = require("fs")
path = require("path")
Sequelize = require("sequelize")
lodash = require("lodash")
sequelize = new Sequelize("sequelize_test", "root", "MPJzfq97", dialect: "postgres")
db = {}
fs.readdirSync(__dirname).filter((file) ->
  (file.indexOf(".") isnt 0) and (file isnt "index.coffee")
).forEach (file) ->
  model = sequelize.import(path.join(__dirname, file))
  db[model.name] = model

Object.keys(db).forEach (modelName) ->
  db[modelName].options.associate db  if db[modelName].options.hasOwnProperty("associate")

module.exports = lodash.extend(
  sequelize: sequelize
  Sequelize: Sequelize
, db)

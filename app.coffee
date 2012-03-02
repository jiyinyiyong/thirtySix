
app = (require 'express').createServer()
io = (require 'socket.io').listen app
app.listen 8000
io.set('log level', 1);

render_page = (require 'jade').compile
fs = require 'fs'
stylus = require 'stylus'

dictory = {}
fs.readFile __dirname+'/mabiao/new_mabiao.txt', 'utf8', (err, data) ->
  lines = data.split '\n'
  for line in lines
    if match = line.match /^(\w{3}):\w+\d=(.*)$/
      key = match[1]
      value = match[2].split ' '
      dictory[key] = value

app.get '/', (req, res) ->
  fs.readFile __dirname+'/client/index.jade', 'utf8', (err, data) ->
    if err then throw err
    page = (render_page data)()
    res.end page

app.get '/page.styl', (req, res) ->
  fs.readFile __dirname+'/client/page.styl', 'utf8', (err, data) ->
    if err then throw err
    stylus.render data, filename: __dirname+'client/page.styl', (err, css) ->
      res.end css

app.get '/client.coffee', (req, res) ->
  fs.readFile __dirname+'/client/client.coffee', 'utf8', (err, data) ->
    if err then throw err
    res.end data

io.sockets.on 'connection', (socket) ->
  socket.emit 'news', hello: 'world'
  socket.on 'my other event', (data) ->
    console.log data
  socket.on 'key', (tri) ->
    console.log tri
    socket.emit 'value', dictory[tri]
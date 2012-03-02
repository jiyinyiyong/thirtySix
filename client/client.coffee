
# code of available letter keys
code =
  q: 113
  w: 119
  e: 101
  r: 114
  t: 116
  y: 121
  u: 117
  i: 105
  a: 97
  s: 115
  d: 100
  f: 102
  g: 103
  h: 104
  j: 106
  k: 107

$ ->
  socket = io.connect window.location.hostname
  socket.on 'news', (data) ->
    console.log data
    socket.emit 'my other event', ny: 'data'
  socket.emit 'key', 'www'
  socket.on 'value', (data) ->
    if data then console.log data
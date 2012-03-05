
$ ->
  socket = io.connect window.location.hostname
  socket.on 'news', (data) ->
    console.log data
    socket.emit 'my other event', ny: 'data'
  # begin to set behavior
  tri = ''
  available = 'qwertyuiasdfghjk'
  all = []
  display = []
  curse = 0
  document.onkeypress = (e) ->
    # event here to send key to the server
    code = e.keyCode
    if code is 0 then code = e.charCode
    console.log code
    press = String.fromCharCode code
    if press in available
      if tri.length < 2
        tri += press
        ($ '#input').text tri
      else
        if press isnt 'q'
          tri += press
          socket.emit 'key', tri
          ($ '#input').text tri
          tri = ''
    # about to select charactor in (display) which defined below
    else if code is 61
      show = ''
      if typeof all[curse+8] isnt 'undefined'
        curse += 8
        display = all[curse...curse+8]
        for i in [0..display.length-1]
          show += "#{i+1}: #{display[i]}; "
        ($ '#selector').text show
    else if code is 45
      show = ''
      if typeof all[curse-8] isnt 'undefined'
        curse -= 8
        display = all[curse...curse+8]
        for i in [0..display.length-1]
          show += "#{i+1}: #{display[i]}; "
        ($ '#selector').text show
    else if press in '12345678'
      charactor = display[Number press - 1]
      if typeof charactor isnt 'undefined'
        text_x = ($ '#text').text()
        console.log text_x
        texts =  text_x + charactor
        console.log texts
        ($ '#text').text texts
        all = []
        display = []
        curse = 0
        ($ '#selector').text '->'
    else if press in ',.'
      ($ '#text').text (($ '#text').text() + press)
    else if press is ' '
      ($ '#text').text (($ '#text').text() + ' ')
  # backspace is different, need to catch with keydown
  document.onkeydown = (e) ->
    if e.keyCode is 8
      content = ($ '#text').text()
      ($ '#text').text content[0...-1]
  socket.on 'value', (data) ->
    unless data
      ($ '#selector').text 'nothing'
    else
      show = ''
      all = data
      if data.length <= 8
        display = data
        curse = 0
      else
        display = data[0...8]
        curse = 0
      for i in [0..display.length-1]
        show += "#{i+1}: #{display[i]}; "
      ($ '#selector').text show

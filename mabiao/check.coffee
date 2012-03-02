
fs = require 'fs'
o = console.log
fs.readFile 'mabiao.txt', 'utf8', (err, data) ->
  lines = data.split '\n'
  mabiao = {}
  for line in lines
    if match = line.match /^(\w+\d)=/
      key = match[1]
      mabiao[key] = 'm'
  fs.readFile 'new_mabiao.txt', 'utf8', (err, new_data) ->
    new_lines = new_data.split '\n'
    new_mabiao = {}
    for new_line in new_lines
      if new_match = new_line.match /:(\w+\d)=/
        new_key = new_match[1]
        new_mabiao[new_key] = 'nm'
    # new begin to check
    for check_key, check_value of mabiao
      if typeof new_mabiao[check_key] is 'undefined'
        o check_key
    o '-------------------------------------'
    for check_key, check_value of new_mabiao
      if typeof mabiao[check_key] is 'undefined'
        o check_key
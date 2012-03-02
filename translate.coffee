
# (sheng 5, 4)
sheng = [
  ['b',  'p',  'm',  'f'],
  ['d',  't',  'n',  'l'],
  ['g',  'k',  'h',  '0'],
  ['zh', 'ch', 'sh', 'r'],
  ['z',  'c',  's',  '_']
]
# (yun 16, 3)
yun = [
  ['a',    'ia',   'ua'  ],
  ['o',    'io',   'uo'  ],
  ['e',    'ie',   've'  ],
  ['_',    'i',    'u'   ],
  ['ang',  'iang', 'uang'],
  ['eng',  'ing',  'ueng'],
  ['ong',  'iong', '_'   ],
  ['van',  'v',    'vn'  ],
  ['ai',   'er',   'uai' ],
  ['ao',   'iao',  '_'   ],
  ['ou',   'iu',   '_'   ],
  ['ei',   '_',    'ui'  ],
  ['an',   'ian',  'uan' ],
  ['_',    '_',    '_'   ],
  ['en',   'in',   'un'  ],
  ['_',   '_',    '_'   ],
]
diao = ['1', '2', '3', '4']

# available words listed here
available = 'qwertyuiasdfghjk'

# check if string is available
check = (tri) ->
  for i in tri
    unless i in available then return false
  return true

# get the sheng row index in (tri)
get_sheng_row = (tri) ->
  x = tri[2]
  if x in 'was' then return 0
  if x in 'erd' then return 1
  if x in 'tfg' then return 2
  if x in 'hyu' then return 3
  if x in 'ijk' then return 4
  else return 'error in get_sheng_row'

# get the sheng column index in (tri)
get_sheng_column = (tri) ->
  x = tri[0]
  if x in 'qwer' then return 0
  if x in 'tyui' then return 1
  if x in 'asdf' then return 2
  if x in 'ghjk' then return 3
  else return 'error in get_sheng_column'

# get then yun row index in (tri)
get_yun_row = (tri) ->
  x = tri[1]
  if x is 'q' then return 0
  if x is 'w' then return 1
  if x is 'e' then return 2
  if x is 'r' then return 3
  if x is 't' then return 4
  if x is 'y' then return 5
  if x is 'u' then return 6
  if x is 'i' then return 7
  if x is 'a' then return 8
  if x is 's' then return 9
  if x is 'd' then return 10
  if x is 'f' then return 11
  if x is 'g' then return 12
  if x is 'h' then return 13
  if x is 'j' then return 14
  if x is 'k' then return 15
  else return 'error in get_yun_row'

# get the yun column index of (tri)
get_yun_column = (tri) ->
  x = tri[2]
  if x in 'adfhj' then return 0
  if x in 'wrtui' then return 1
  if x in 'segyk' then return 2
  else return 'error in get_yun_column'

# get diao if (tri) ->
get_diao = (tri) ->
  x = tri[0]
  if x in 'qtag' then return 0
  if x in 'wysh' then return 1
  if x in 'eudj' then return 2
  if x in 'rifk' then return 3
  else return 'error in diao'

# put in available string (tri) like 'qwe'
translate = (tri) ->
  s_r = get_sheng_row tri
  s_c = get_sheng_column tri
  y_r = get_yun_row tri
  y_c = get_yun_column tri
  d_n = get_diao tri
  word = sheng[s_r][s_c] + yun[y_r][y_c] + diao[d_n]
  word = word.replace /^0u(\d)/, 'wu$1'
  word = word.replace /^0i(\d)/, 'yi$1'
  word = word.replace /^0ui(\d)/, 'wei$1'
  word = word.replace /^0in/, 'yin'
  word = word.replace /^0un/, 'wen'
  word = word.replace /^0uen/, 'wen'
  word = word.replace /^0ia/, 'ya'
  word = word.replace /^0io/, 'yo'
  word = word.replace /^0ie/, 'ye'
  word = word.replace /^0iu/, 'you'
  word = word.replace /^0ua/, 'wa'
  word = word.replace /^0uo/, 'wo'
  word = word.replace /^0v/, 'yu'
  word = word.replace /^0a/, 'a'
  word = word.replace /^0e/, 'e'
  word = word.replace /^0o/, 'o'
  word = word.replace /^gi/, 'ji'
  word = word.replace /^ki/, 'qi'
  word = word.replace /^hi/, 'xi'
  word = word.replace /^gv/, 'ju'
  word = word.replace /^kv/, 'qu'
  word = word.replace /^hv/, 'xu'
  word = word.replace /^ui/, 'wei'
  word = word.replace /ve/, 'ue'
  word = word.replace /([nl])ue/, '$1ve'
  word = word.replace /^eng/, 'ng'
  return word

# load file to compare (tri)s and (pinyin)s
fs = require 'fs'
fs.readFile 'mabiao.txt', 'utf8', (err, data) ->
  # if err then throw err
  lines = data.split '\n'
  word = {}
  for line in lines
    match = line.match /^(\w+\d)=(.*)/
    pinyin = match[1]
    charactors = match[2]
    # handle sth like "de5", change them into "de1"
    if pinyin.match /5$/
      pinyin_ = pinyin[0..-2]+'1'
      if typeof word[pinyin_] isnt 'array'
        word[pinyin_] = charactors.split ' '
      else
        for charactor in charactors
          word[pinyin_] = word[pinyin_].push charactor
    else
      match = line.match /^(\w+\d)=(.*)/
      pinyin = match[1]
      charactors = match[2]
      word[pinyin] = charactors.split ' '
  # begin to filter (tri)s
  text = ''
  collection = {}
  for i in available
    for j in available
      for k in available[1..]
        tri = i+j+k
        key = translate tri
        if typeof word[key] isnt 'undefined'
          line = "#{tri}:#{key}=#{word[key].join ' '}"
          text += line + '\n'
          collection[key] = 'taken'
        else
          unless key.match /_/
            console.log key, ' ::left'
  for keyx, valuex of word
    if typeof collection[keyx] isnt 'string'
      console.log keyx, collection[keyx]
  fs.writeFile 'new_mabiao.txt', text, (err) ->
    if err then throw err
    console.log 'done!'
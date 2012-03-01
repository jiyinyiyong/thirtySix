
# (sheng 5, 4)
sheng = [
  ['b',  'p',  'm',  'f'],
  ['d',  't',  'n',  'l'],
  ['g',  'k',  'h',  '0'],
  ['zh', 'ch', 'sh', 'r'],
  ['z',  'c',  's',  '' ]
]
# (yun 16, 3)
yun = [
  ['a',    'ia',   'ua'  ],
  ['o',    'io',   'uo'  ],
  ['e',    'ie',   've'  ],
  ['',     'i',    'u'   ],
  ['ang',  'iang', 'uang'],
  ['ong',  'iong', ''    ],
  ['van',  'v',    'vn'  ],
  ['ai',   'er',   'uai' ],
  ['ao',   'iao',  ''    ],
  ['ou',   'iu',   ''    ],
  ['ei',   '',     'ui'  ],
  ['an',   'ian',  'uan' ],
  ['',     '',     ''    ],
  ['en',   'in',   'un'  ],
  ['',     '',     ''    ],
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
  return word

for i in available[1..4]
  for j in available[1..4]
    for k in available[1..4]
      console.log translate (i+j+k)
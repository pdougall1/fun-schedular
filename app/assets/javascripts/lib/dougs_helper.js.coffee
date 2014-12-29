class @DougsHelper

  getRandom: (min, max) ->
    return min + Math.floor(Math.random() * (max - min + 1))   

  subtractFloat: (one, two) ->
    one_dec = one.toString().split('.')[1] || []
    two_dec = two.toString().split('.')[1] || []
    max_dec = Math.max.apply( Math, [one_dec.length, two_dec.length] )
    parseFloat(Number(one - two).toFixed(max_dec))

  roundDec: (num, dec_num) ->
    num = parseFloat(num)
    dec_num || = ((num + 0.00001) * 100)
    Math.round(dec_num) / 100

  clean: (arr) ->
    temp = []
    for i in arr
      temp.push(i) if i 
    temp

  camelize: (str) ->
    # this needs some work!
    if str
      str.replace(/^#/, "").toLowerCase().replace /[_-\s](.)/g, (match, group1) ->
        group1.toUpperCase()

  toUnderscore: (str) ->
    cStr = str.replace /[_-](.)/g, (match, group1) -> group1.toUpperCase()
    cStr.replace /([A-Z])/g, (group1) ->
      "_" + group1.toLowerCase()

  humanize: (str) ->
    # take any string and divide words by spaces
    # provide capitalize parameter
    str.replace(/^#/, "").replace("_", " ")    

  isJson: (str) -> 
    try
      # JSON.parse([1]) is truthy 
      return false if Object.prototype.toString.call(str) == "[object Array]"
      json = JSON.parse(str)
    catch 
      return false
    str

  isArray: (data) ->
    return true if @dataObjectType(data) == 'array'
    false

  isNumber: (data) ->
    return true if @dataObjectType(data) == 'number'
    false

  isString: (data) -> 
    return true if @dataObjectType(data) == 'string'
    false

  isObject: (data) -> 
    return true if @dataObjectType(data) == 'object'
    false

  dataObjectType: (data)->
    dataIs = 'array' if Object.prototype.toString.call(data) is "[object Array]"
    dataIs = 'string' if Object.prototype.toString.call(data) is "[object String]"
    dataIs = 'object' if Object.prototype.toString.call(data) is "[object Object]"
    dataIs = 'json' if @isJson(data) # must be before number check
    dataIs = 'number' if Object.prototype.toString.call(data) is "[object Number]"
    dataIs

  capitalize: (str) ->
    str.charAt(0).toUpperCase() + str.slice(1)

  gsub: (source, pattern, replacement) ->
    unless pattern? and replacement?
      return source
    result = ''
    while source.length > 0
      if (match = source.match(pattern))
        result += source.slice(0, match.index)
        result += replacement
        source  = source.slice(match.index + match[0].length)
      else
        result += source
        source = ''
    result

  emailRegEx: /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

  validEmail: (email) ->
    @emailRegEx.test(email)

  

class @CookieHelper extends @DougsHelper

  set: (name, value, days) ->
    d = new Date()
    d.setTime(d.getTime() + days * 24 * 60 * 60 * 1000)
    expires = "expires=#{d.toGMTString()}"
    document.cookie = "#{name}=#{JSON.stringify value}; #{expires}"

  get: (name) ->
    name = "#{name}="
    for c in document.cookie.split(';')
      c = c.trim()
      if (c.indexOf(name)==0)
        value = c.substring(name.length,c.length)
        if v = dougs.isJson value
          return v
        else
          return value

  delete: (name) ->
    d = new Date()
    d.setTime(d.getTime() - 1000)
    expires = "expires=#{d.toGMTString()}"
    document.cookie = "#{name}=#{JSON.stringify("x")}; #{expires}"


class @LocalStorage extends @DougsHelper

  set: (key, value) ->
    value = JSON.stringify(value) unless @isJson(value)
    localStorage.setItem(key, value)

  get: (key) ->
    value = localStorage.getItem(key)
    JSON.parse(value)

  delete: (key) ->
    localStorage.removeItem(key)    




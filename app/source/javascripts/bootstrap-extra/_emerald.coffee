window.EmVars = {

  #helper to pull the json with colors from a :before selector
  varsJson: ->
    style = null
    emvars = $('#emvars')[0]
    if window.getComputedStyle and window.getComputedStyle(emvars, "::before")
      style = window.getComputedStyle(emvars, ':after')?.getPropertyValue('content')
      style
    else
      window.getComputedStyle = (el) ->
        @el = el
        @getPropertyValue = (prop) ->
          re = /(\-([a-z]){1})/g
          if re.test(prop)
            prop = prop.replace(re, ->
              arguments[2].toUpperCase()
            )
          (if el.currentStyle[prop] then el.currentStyle[prop] else null)

        this

      style = window.getComputedStyle(document.getElementsByTagName("head")[0])
      style = style.getPropertyValue("font-family")
    if style.length > 0
      style = style.replace(/^['"]+|\s+|\\|(;\s?})+|['"]$/g, "")  if typeof style is "string" or style instanceof String
      if style.length > 0
        try
          return JSON.parse(style)
        catch error
          return null

  #where the magic happens. pull the colors from the css to use them in javascript
  #will result in an object with color names
  #currently called in init
  colorsFromSass: ->
    varsJson = EmVars.varsJson()
    colors = {}
    if varsJson
      jsonColors = varsJson.colors
      _.each jsonColors, (ary) -> colors[ary[0]] = { color: ary[1], inverseColor: ary[2] }

    colors

  #raw color helpers, only adjust lighting. needs a hex color to send forward
  lter: (color) -> EmVars.shadeColor(color, 20)
  lt: (color, percent=10) -> EmVars.shadeColor(color, percent)
  dk: (color, percent=10) -> EmVars.shadeColor(color, -percent)
  dker: (color) -> EmVars.shadeColor(color, -20)

  colorFromName: (name) ->
    emColor = EmVars.colors[name].color
    #scss outputs named values too, like 'white', we want hex colors
    EmVars.colourNameToHex(emColor) || emColor

  textColor: '#6c757b'

  #helpers for demo purposes
  helpers: {
    words: ['Automotive', 'Locomotive', 'Unmotivated', 'Three', 'Four', 'Five'],
    monthNames: ['January', 'February','March','April','May','June','July','August','September','October','November','December']
    abbrDays: ['Su','Mo','Tu','We','Th','Fr','Sa']
  }

  #this just converts a color like 'white' to '#ffffff'. some plugins require hex
  colourNameToHex: (colour) ->
    colours = {"aliceblue":"#f0f8ff","antiquewhite":"#faebd7","aqua":"#00ffff","aquamarine":"#7fffd4","azure":"#f0ffff", "beige":"#f5f5dc","bisque":"#ffe4c4","black":"#000000","blanchedalmond":"#ffebcd","blue":"#0000ff","blueviolet":"#8a2be2","brown":"#a52a2a","burlywood":"#deb887", "cadetblue":"#5f9ea0","chartreuse":"#7fff00","chocolate":"#d2691e","coral":"#ff7f50","cornflowerblue":"#6495ed","cornsilk":"#fff8dc","crimson":"#dc143c","cyan":"#00ffff", "darkblue":"#00008b","darkcyan":"#008b8b","darkgoldenrod":"#b8860b","darkgray":"#a9a9a9","darkgreen":"#006400","darkkhaki":"#bdb76b","darkmagenta":"#8b008b","darkolivegreen":"#556b2f", "darkorange":"#ff8c00","darkorchid":"#9932cc","darkred":"#8b0000","darksalmon":"#e9967a","darkseagreen":"#8fbc8f","darkslateblue":"#483d8b","darkslategray":"#2f4f4f","darkturquoise":"#00ced1", "darkviolet":"#9400d3","deeppink":"#ff1493","deepskyblue":"#00bfff","dimgray":"#696969","dodgerblue":"#1e90ff", "firebrick":"#b22222","floralwhite":"#fffaf0","forestgreen":"#228b22","fuchsia":"#ff00ff", "gainsboro":"#dcdcdc","ghostwhite":"#f8f8ff","gold":"#ffd700","goldenrod":"#daa520","gray":"#808080","green":"#008000","greenyellow":"#adff2f", "honeydew":"#f0fff0","hotpink":"#ff69b4", "indianred ":"#cd5c5c","indigo":"#4b0082","ivory":"#fffff0","khaki":"#f0e68c", "lavender":"#e6e6fa","lavenderblush":"#fff0f5","lawngreen":"#7cfc00","lemonchiffon":"#fffacd","lightblue":"#add8e6","lightcoral":"#f08080","lightcyan":"#e0ffff","lightgoldenrodyellow":"#fafad2", "lightgrey":"#d3d3d3","lightgreen":"#90ee90","lightpink":"#ffb6c1","lightsalmon":"#ffa07a","lightseagreen":"#20b2aa","lightskyblue":"#87cefa","lightslategray":"#778899","lightsteelblue":"#b0c4de", "lightyellow":"#ffffe0","lime":"#00ff00","limegreen":"#32cd32","linen":"#faf0e6", "magenta":"#ff00ff","maroon":"#800000","mediumaquamarine":"#66cdaa","mediumblue":"#0000cd","mediumorchid":"#ba55d3","mediumpurple":"#9370d8","mediumseagreen":"#3cb371","mediumslateblue":"#7b68ee", "mediumspringgreen":"#00fa9a","mediumturquoise":"#48d1cc","mediumvioletred":"#c71585","midnightblue":"#191970","mintcream":"#f5fffa","mistyrose":"#ffe4e1","moccasin":"#ffe4b5", "navajowhite":"#ffdead","navy":"#000080", "oldlace":"#fdf5e6","olive":"#808000","olivedrab":"#6b8e23","orange":"#ffa500","orangered":"#ff4500","orchid":"#da70d6", "palegoldenrod":"#eee8aa","palegreen":"#98fb98","paleturquoise":"#afeeee","palevioletred":"#d87093","papayawhip":"#ffefd5","peachpuff":"#ffdab9","peru":"#cd853f","pink":"#ffc0cb","plum":"#dda0dd","powderblue":"#b0e0e6","purple":"#800080", "red":"#ff0000","rosybrown":"#bc8f8f","royalblue":"#4169e1", "saddlebrown":"#8b4513","salmon":"#fa8072","sandybrown":"#f4a460","seagreen":"#2e8b57","seashell":"#fff5ee","sienna":"#a0522d","silver":"#c0c0c0","skyblue":"#87ceeb","slateblue":"#6a5acd","slategray":"#708090","snow":"#fffafa","springgreen":"#00ff7f","steelblue":"#4682b4", "tan":"#d2b48c","teal":"#008080","thistle":"#d8bfd8","tomato":"#ff6347","turquoise":"#40e0d0", "violet":"#ee82ee", "wheat":"#f5deb3","white":"#ffffff","whitesmoke":"#f5f5f5", "yellow":"#ffff00","yellowgreen":"#9acd32"}
    if typeof(colours[colour.toLowerCase()])?
      return colours[colour.toLowerCase()]

  #random function for demo purposes (syntactic sugar)
  rand: (min,max) -> Math.floor(Math.random()*(max-min+1)+min)

  #function to add alpha to a hex color (results in a rgba form)
  adjustOpacity: (hexColor, opacity) ->
    rgb = EmVars.hexToRgb hexColor
    "rgba(#{rgb.r}, #{rgb.g}, #{rgb.b}, #{opacity})"

  #converts hexToRgb
  hexToRgb: (hex) ->
    # Expand shorthand form (e.g. "03F") to full form (e.g. "0033FF")
    shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i
    hex = hex.replace(shorthandRegex, (m, r, g, b) ->
      r + r + g + g + b + b
    )
    result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex)
    if result
      r: parseInt(result[1], 16)
      g: parseInt(result[2], 16)
      b: parseInt(result[3], 16)
    else
      null

  #ex: shadeColor('#50395A', 33) - adjust the lighting to a color
  shadeColor: (color, percent) ->
    R = parseInt(color.substring(1, 3), 16)
    G = parseInt(color.substring(3, 5), 16)
    B = parseInt(color.substring(5, 7), 16)
    R = parseInt(R * (100 + percent) / 100)
    G = parseInt(G * (100 + percent) / 100)
    B = parseInt(B * (100 + percent) / 100)
    R = (if (R < 255) then R else 255)
    G = (if (G < 255) then G else 255)
    B = (if (B < 255) then B else 255)
    RR = ((if (R.toString(16).length is 1) then "0" + R.toString(16) else R.toString(16)))
    GG = ((if (G.toString(16).length is 1) then "0" + G.toString(16) else G.toString(16)))
    BB = ((if (B.toString(16).length is 1) then "0" + B.toString(16) else B.toString(16)))
    "#" + RR + GG + BB

  colorList: (n=0) ->
    list = _.map EmVars.colors, (item) -> item.color
    return list[0...n] if n > 0
    return list
}

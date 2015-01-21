window.BSE = {
  Utils: {
    Mq: {},
    Ua: {},
    Id: {}
  }
}

# media queries
Mq = BSE.Utils.Mq

# return the current media query screen, one of xs, sm, md, lg
# needs the <div id="mq"></div> element just before the </body>
Mq.screen = -> Mq.screenMq() || Mq.screenFallback()
Mq.screens = 
  '(max-width: 767px)': 'xs'
  '(min-width: 768px) and (max-width: 991px)': 'sm'
  '(min-width: 992px) and (max-width: 1199px)': 'md'
  '(min-width: 1200px)': 'lg'
Mq.screenMq = -> window.getComputedStyle($('#mq')[0], ':after')?.getPropertyValue('content').replace(/"/g,'')
Mq.screenFallback = -> _.find Mq.screens, (screen, query) -> Modernizr.mq(query)

# user agent
Ua = BSE.Utils.Ua
Ua.isMobile = navigator.userAgent.match(/(iPhone|iPod|iPad|Android|BlackBerry)/)

# id helpers

window.hashCode = (str) ->
	hash = 0
	return hash if str.length == 0
	for i in [0...str.length]
		char = str.charCodeAt(i)
		hash = ((hash << 5) - hash) + char
		hash = hash & hash
	if hash < 0 then -1 * hash else hash

Id = BSE.Utils.Id
$(document).on 'page:load', -> Id.rid_seq = 0 # reset on tblinks

# generates unique repeatable ids that can be used ask keys for elements peristence
Id.rid = ->
  @rid_seq = if @rid_seq? then @rid_seq else 0
  @rid_seq += 1
  "jsrid#{hashCode(window.location.href)}#{@rid_seq}"

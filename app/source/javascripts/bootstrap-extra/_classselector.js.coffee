template = """
  <div class="dropdown dropdown-classselector">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
      <span class="btn-classselector"></span>
    </a>
    <ul class="dropdown-menu dropdown-caret">
      <% for (var i = 0; i < classes.length; i++) { %>
      <li>
        <a href="#" class="btn-classselector-class <%= classes[i] %>" data-class="<%= classes[i] %>">
          <span class="btn-classselector-class <%= classes[i] %>" data-class="<%= classes[i] %>"></span>
        </a>
      </li>
      <% } %>
    </ul>
  </div>
"""

class ClassSelector

  template: _.template(template)
  
  constructor: (element, @options) ->
    @$element = $(element)
    @classes = @$element.find('option').map -> $(@).val()
    @$element.hide()
    @$classSelector = $(@template(@))
    @$classSelector.insertAfter(@$element)
    @$options = @$classSelector.find('a.btn-classselector-class span')
    val = @$element.val()
    @setValue(val) if val
    that = this
    @$options.on 'click', ->
      $this = $(this)
      value = $this.data('class')
      that.setValue(value, true)
      
  setValue: (value, trigger = false) ->
    @$element.val(value)
    @$element.change() if trigger
    @$options.removeClass('selected')
    @$options.filter(".#{value}").addClass('selected')


$.fn.classselector = (option, args...) ->
  @each ->
    $this = $(this)
    data = $this.data("classselector")
    options = $.extend({}, $this.data(), typeof option == "object" && option)
    if !data
      data = new ClassSelector(this, options)
      $this.data("classselector", data)
    if typeof option == "string"
      data[option].apply(data, args)

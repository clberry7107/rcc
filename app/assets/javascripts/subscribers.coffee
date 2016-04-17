# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
show_whirly = (display) ->
  $('#whirly').css('display','#[display}')
  
 
jQuery ->
  $("a[data-show_whirly]").click (e) ->
    e.preventDefault()
    display = $(this).data.show_whirly
    show_whirly(display)
    
  $(document).on "page:load", ->
    show_whirly('none')
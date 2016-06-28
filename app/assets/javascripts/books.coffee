# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#search').keyup (e) ->
    searchTable($(this).val())
  
  $('#search').keypress (e) ->
    if e.keycode == 13
      e.preventDefault()
      
    $('.clear').click (e) ->
    show_selected(e)
    
    
  $('.clean').click ->
    cleanRequest()
    
  $('.consolidate').click (e) ->
    consolidate(e)
    
  $('#inp').on('keydown', onlyNumbers)

    
searchTable = (inputVal) ->
  regExp = new RegExp(inputVal, 'i')
  table = $('.search_table')
  table.find('tr').each (index, row) ->
    if index != 0
      allCells = $(row).find('td')
      if(allCells.length > 0)
        found = false
        allCells.each (index, td) ->
          if(regExp.test($(td).text()))
            found = true;
            return false;
        if(found == true)
          $(row).fadeIn()
        else
          $(row).fadeOut()
  
          
cleanRequest = () ->
  removeRow = []
  table = $('.search_table')
  table.find('tr').each (index, row) ->
    if index != 0
      allCells = $(row).find('td')
      allCells.each (cell, td) ->
        if cell == 2
          quantity = $(td).children(0).val()
        if quantity == ""
          removeRow.unshift index
  removeRow.forEach (item, i) ->
    $("tr:eq(#{item})").remove()
  
consolidate = (e) ->
  # alert "Consolidating"
  table = $('.search_table')
  table.find('tr').each (index, row) ->
    if index != 0
      allCells = $(row).find('td')
      allCells.each (cell, td) ->
        if cell == 2
          quantity = $(td).children(0).val()
        if quantity < 1
          $(row).fadeOut()
        else
          $(row).fadeIn()
  e.preventDefault()
  
# show_selected = (e) ->
#   # alert "Consolidating"
#   table = $('.search_table')
#   table.find('tr').each (index, row) ->
#     if index != 0
#       allCells = $(row).find('td')
#       allCells.each (cell, td) ->
#         if cell == 0
#           selected = $(td).children(0).val()
#         if selected == 1
#           $(row).fadeOut()
#         else
#           $(row).fadeIn()
#   e.preventDefault()
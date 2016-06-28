# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#search').keyup (e) ->
    searchTable($(this).val())
  
  $('#search').keypress (e) ->
    if e.keycode == 13
      e.preventDefault()
    
    
  $('.clean').click ->
    cleanRequest()
    
  $('.consolidate').click (e) ->
    consolidate(e)
    
  $('.clear').click (e) ->
    show_selected(e)
    
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
  
  show_selected = (e) ->
  # alert "Consolidating"
  table = $('.search_table')
  table.find('tr').each (index, row) ->
    if index != 0
      allCells = $(row).find('td')
      allCells.each (cell, td) ->
        if cell == 0
          selected = $(td).children(0).val()
        if selected == 1
          $(row).fadeOut()
        else
          $(row).fadeIn()
  e.preventDefault()
    
  
onlyNumbers = (evt) ->
    #SOME OPTIONS LIKE ENTER, BACKSPACE, HOME, END, ARROWS, ETC.
    # arrayExceptions = [8, 13, 16, 17, 18, 20, 27, 35, 36, 37,38, 39, 40, 45, 46, 144]
    # if (evt.keyCode < 48 || evt.keyCode > 57) &&
    #     (evt.keyCode < 96 || evt.keyCode > 106) && // NUMPAD
    #     $.inArray(evt.keyCode, arrayExceptions) === -1
    #     return false;
    



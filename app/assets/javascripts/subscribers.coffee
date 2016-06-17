# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#search').keyup ->
    # alert("button pushed")
    searchTable($(this).val())

    
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
#= require jquery-1.8.2.min.js
#= require 2.5.3-crypto-sha256.js
#= require jsbn.js
#= require jsbn2.js
#= require check_address.js

$(->
  symbols = ['bitstampUSD', 'virtexCAD', 'mtgoxUSD']
  symbols = symbols.sort()

  user = $('#username').val()
  if user
    $('#setup').attr('action', "/#{user}/update").attr('method', 'post')

  $.each(symbols, (i, v) ->
    $('#symbol').append("<option value='#{v}'>#{v}</option>")
  )
  $("#symbol option[value='virtexCAD']").attr('selected', 'selected')

  $('#address').change(->
    if check_address($(this).val())
      $(this).css('color', 'black')
    else
      $(this).css('color', 'red')
  )

)

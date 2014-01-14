#= require jquery-2.0.3.min.js
#= require moment.min.js
#= require qrcode.min.js
#= require bootstrap.min.js
#= require 2.5.3-crypto-sha256.js
#= require jsbn.js
#= require jsbn2.js
#= require check_address.js

EXCHANGE_FAIL = "Error fetching exchange rate"
SOCKET_FAIL = "Error connecting to payment server"
ADDRESS_FAIL = "Invalid address"

g = exports ? this

$(->
  unless Boolean(window.chrome)
    document.write('Must use chrome')
    return

  g.errors = []
  g.orders = []
  g.unit = 'mBTC'

  if user.title 
    $('#title').html(user.title).show()

  if user.logo
    $('#logo').attr('src', user.logo).show()
  else unless user.title
    $('#logo').attr('src', '/img/bitcoin_coop.png').show()

  user.symbol ||= 'virtexCAD'
  $('#symbol').html(user.symbol)
  $('#currency').html(user.symbol.slice(-3))
  $('#received').hide()

  # setInterval(keepSocketsAlive, 5000)
  # fetchExchangeRate()
  fakeExchangeRate()

  $('#amount').focus(->
    $('#received').hide()
    $(this).val('')
  )

  $('form#calculator').submit((e) ->
    if isNumber($('#amount').val())
      $('#amount').css('border-color', 'blue')
      createOrder()
    else
      $('#amount').css('border-color', 'red')

    e.preventDefault()
  )

  $('body').on('click', '.btn-danger', ->
    $(this).closest('.btn-block').hide()
  )

  $('body').on('click', '.order', ->
    $('.order').addClass('small')
    $(this).removeClass('small')
  )
)

getAddress = (-> 
  addresses = ['1VAnbtCAnYccECnjaMCPnWwt81EHCVgNr','18DtqERJnnaBktezXfFXqYVSnCYWd6trZm']
  cc = 0
  ->
    cc = (cc + 1) % addresses.length
    addresses[cc]
)()

createOrder = ->
  precision = 9 - multiplier().toString().length
  address = getAddress()
  amount = parseFloat($('#amount').val())
  total = (amount * multiplier() / g.exchange).toFixed(precision)
  unless $.isNumeric(total)
    total = ''

  order = 
    id: g.orders.length
    total: total
    address: address
    socket: null

  # createSocket(order)
  g.orders.push(order)

  div = $('.ordertemplate').clone()
  div.attr('id', "order_#{order.id}")
  div.attr('class', 'order btn btn-block')
  $('#calculator').after(div)

  div.find('.fiat_total').html(amount.toFixed(2))
  div.find('.bitcoin_total').html(total.toString())
  div.find('.unit').html(g.unit)
  div.find('.address').html(address)
  div.find('.qr').attr('id', "qr_#{order.id}").html('')
  qr = new QRCode("qr_#{order.id}", 
    width: 180, 
    height: 180
  )
  qr.makeCode("bitcoin:#{address}?amount=#{total.toString()}")

  if $('.order').length > 1
    $('.order:nth-child(3)').animate(marginTop: '100px', ->
      $(this).addClass('small')
      $(this).css('margin-top', 0)
      div.fadeIn()
    )
  else
    div.fadeIn()


fakeExchangeRate = ->
  clear(EXCHANGE_FAIL)
  g.exchange = 420.00
  $('#exchange').val(g.exchange.toFixed(2))
  finalize() 

fetchExchangeRate = ->
  $.ajax(
    url: "ticker?symbol=#{user.symbol}&type=ask&amount=1000",
    success: (exchange) -> 
      if exchange?
        clear(EXCHANGE_FAIL)
      else
        fail(EXCHANGE_FAIL)
        return

      unless g.setupComplete
        finalize() 

      g.exchange = exchange - exchange * user.commission * 0.01
      $('#exchange').val(g.exchange.toFixed(2))
    error: -> fail(EXCHANGE_FAIL)
  )
  setTimeout(fetchExchangeRate, 900000)

finalize = ->
  $('#amount').focus()
  g.setupComplete = true

createSocket = (order) ->
  unless order.socket and order.socket.readyState is 1
    order.socket = new WebSocket("ws://ws.blockchain.info/inv")

    order.socket.onopen = -> 
      clear(SOCKET_FAIL)
      order.socket.send('{"op":"addr_sub", "addr":"' + order.address + '"}')
    
    order.socket.onerror = ->
      order.socket = null
      fail(SOCKET_FAIL)

    order.socket.onclose = ->
      order.socket = null
      fail(SOCKET_FAIL)

    order.socket.onmessage = (e) ->
      results = eval('(' + e.data + ')')
      total = 0
      received = 0
      
      $.each(results.x.out, (i, v) ->
        if (v.addr == order.address) 
          received += v.value
      )

      if (total <= received) 
        $("#order_#{order.id}").addClass('paid')

fail = (msg) ->
  g.errors.push(msg)
  g.errors = g.errors.uniq()
  $('#calculator').hide()
  $('#error').show().html(g.errors.toString())
  
clear = (msg) ->
  i = g.errors.indexOf(msg)
  g.errors.splice(i, 1) if i >= 0
  if (g.errors.length > 0)
    $('#error').show().html(g.errors.toString())
  else
    $('#error').hide()
    $('#calculator').fadeIn('slow')

get = (name) ->
  name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]")
  regexS = "[\\?&]" + name + "=([^&#]*)"
  regex = new RegExp(regexS)
  results = regex.exec(window.location.search)

  if (results == null)
    ""
  else
    decodeURIComponent(results[1].replace(/\+/g, " "))

multiplier = ->
  switch g.unit
    when 'BTC' then 1
    when 'mBTC' then 1000
    when '&micro;BTC' then 1000000
    when 'satoshis' then 100000000

Array::uniq = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output

isNumber = (n) ->
  !isNaN(parseFloat(n)) && isFinite(n) && n > 0



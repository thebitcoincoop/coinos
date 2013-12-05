#= require jquery-1.8.2.min.js
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
  g.addresses = ['1VAnbtCAnYccECnjaMCPnWwt81EHCVgNr','18DtqERJnnaBktezXfFXqYVSnCYWd6trZm']

  g.user = $('#user').val()
  g.title = get('title')
  g.symbol = get('symbol')
  g.commission = parseFloat(get('commission'))
  g.logo = get('logo')
  g.errors = []
  g.orders = []
  g.unit = 'mBTC'

  if g.user
    $.ajax(
      url: g.user + '.json', 
      dataType: 'json',
      success: (data) ->
        if data?
          g.title = data.title
          g.addresses = data.addresses
          g.symbol = data.symbol
          g.commission = data.commission 
          g.logo = data.logo 
        setup()
    )
  else 
    setup()

  $('#amount').focus(->
    $('#received').hide()
    $(this).val('')
  ).focus()

  $('form#calculator').submit((e) ->
    if isNumber($('#amount').val())
      $('#amount').css('border-color', 'blue')
      createOrder()
    else
      $('#amount').css('border-color', 'red')

    e.preventDefault()
  )

  $('.cancel').live('click', ->
    $(this).closest('.order').hide()
  )
)


createOrder = ->
  precision = 9 - multiplier().toString().length
  address = g.addresses.pop()
  amount = parseFloat($('#amount').val())
  total = (amount * multiplier() / g.exchange).toFixed(precision)
  unless $.isNumeric(total)
    total = ''

  g.orders.push(
    amount: total
    address: address
  )
  id = g.orders.length

  order = $('.order').first().clone().hide()
  $('.order').first().before(order)
  order.show()

  order.find('.fiat_total').html(amount.toFixed(2))
  order.find('.bitcoin_total').html(total.toString())
  order.find('.unit').html(g.unit)
  order.find('.address').html(address)
  order.find('.qr').attr('id', "qr_#{id}").html('')
  qr = new QRCode("qr_#{id}", 
    width: 180, 
    height: 180
  )

  qr.makeCode("bitcoin:#{address}?amount=#{total.toString()}")

setup = ->
  g.commission or= 0
  g.symbol or= 'virtexCAD'

  if g.title 
    $('#title').html(g.title).show()

  if g.logo
    $('#logo').attr('src', g.logo).show()
  else unless g.title
    $('#logo').attr('src', '/img/bitcoin_coop.png').show()

  symbol = g.symbol

  $('#symbol').html(symbol)
  $('#currency').html(g.symbol.slice(-3))
  $('#received').hide()

  # setInterval(keepSocketsAlive, 5000)
  # fetchExchangeRate()
  fakeExchangeRate()

fakeExchangeRate = ->
  unless g.setupComplete
    finalize() 
  clear(EXCHANGE_FAIL)
  g.exchange = 420.00
  $('#exchange').val(g.exchange.toFixed(2))

fetchExchangeRate = ->
  $.ajax(
    url: "ticker?symbol=#{g.symbol}&type=ask&amount=1000",
    success: (exchange) -> 
      if exchange?
        clear(EXCHANGE_FAIL)
      else
        fail(EXCHANGE_FAIL)
        return

      unless g.setupComplete
        finalize() 

      g.exchange = exchange - exchange * g.commission * 0.01
      $('#exchange').val(g.exchange.toFixed(2))
    error: -> fail(EXCHANGE_FAIL)
  )
  setTimeout(fetchExchangeRate, 900000)

finalize = ->
  $('#amount').focus()
  g.setupComplete = true

keepAlive = ->
  for order in g.orders
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
        from_address = ''
        total = 0
        received = 0
        
        $.each(results.x.out, (i, v) ->
          if (v.addr == g.address) 
            received += v.value
        )

        $.each(results.x.inputs, (i, v) ->
          from_address = v.prev_out.addr
          if (v.prev_out.addr == g.address) 
            input -= v.prev_out.value
        )

        if (total <= received) 
          $('#amount').blur()
          $('#order').hide()
          $('#received').fadeIn('slow')

        if g.user
          $.post("/#{g.user}/transactions",
            address: from_address,
            date: moment().format("YYYY-MM-DD HH:mm:ss"),
            received: received ,
            exchange: g.exchange
          )

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
  !isNaN(parseFloat(n)) && isFinite(n)

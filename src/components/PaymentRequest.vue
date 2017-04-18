<template lang="pug">
.payment-request
  #calculator
    h1(v-if='title') {{title}}
    img(v-if='logo')
    #controls
      .numpad.pull-left
        h2
          span.amount 0.00
          small.currency
        button.btn.btn-lg.btn-default 1
        button.btn.btn-lg.btn-default 2
        button.btn.btn-lg.btn-default 3
        br
        button.btn.btn-lg.btn-default 4
        button.btn.btn-lg.btn-default 5
        button.btn.btn-lg.btn-default 6
        br
        button.btn.btn-lg.btn-default 7
        button.btn.btn-lg.btn-default 8
        button.btn.btn-lg.btn-default 9
        br
        button.btn.btn-lg.btn-default C
        button.btn.btn-lg.btn-default 0
        button.btn.btn-lg.btn-default(style='padding: 13px 0')
          i.fa.fa-arrow-left
      .tippad.tablet
        h2
          small +
          span.tip
        button.active.btn.btn-lg.btn-default(type='button') No Tip
        br
        button.btn.btn-lg.btn-default(type='button') +10%
        br
        button.btn.btn-lg.btn-default(type='button') +15%
        br
        button.btn.btn-lg.btn-default(type='button') +20%
      .rates.tablet
        h2
          small Exchange rate
          span.exchange
          span.label.label-default.symbol
          span.label.label-success.commission
      .clearfix.mobile
      .tippad.mobile(style='margin-top: 10px')
        h2
          small +
          span.tip
          small TIP
        .btn-group
          button.active.btn.btn-lg.btn-default(type='button') No Tip
          button.btn.btn-lg.btn-default(type='button') +10%
          button.btn.btn-lg.btn-default(type='button') +15%
          button.btn.btn-lg.btn-default(type='button') +20%
      .rates.mobile
        h2
          small Exchange Rate
          br
          span.exchange
          span.label.label-default.symbol
          span.label.label-success.commission
    button#slide.btn.btn-primary
      i.fa.fa-lg.fa-sort-up
    #payment(style='margin-top: -10px')
      h2
        small Please send
        span#total 0.0
        small.unit
      #qr
      h2
        span#address.label.label-success
    button#received.btn.btn-success(type='button') Payment Received. Thank you!
    audio#success(src='/success.wav', hidden='true', enablejavascript='true')
</template>

<script>
</script>

<style lang="stylus">
  div#calculator
    #amount
      width 5em
    #received
      font-size 16px
      width 100%
    strong#total
      font-size 30px
    #address
      padding-top 10px
      a
        color #fff
        text-decoration none
    #title
      display none
      a
        color #000
        text-decoration none
    #logo
      display none
      padding 10px 0
      margin-bottom 10px
      max-height 225px
      width 100%
    #error
      margin-top 10px
    #qr
      padding-bottom 10px
      margin-left 20px

    .numpad
      .btn-primary
          background #abc

  @media (max-width: 360px)
    .tippad
      .btn
          width 4.3em
    .numpad
      .btn
          width 5.7em
    .rates
      width 100%
      text-align left
    #address
      font-size 16px

  #payment
    h2
      margin-bottom 2px

</style>

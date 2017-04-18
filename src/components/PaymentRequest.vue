<template lang="pug">
  .payment-request
    h1(v-if='user.title') {{user.title}}
    img(v-if='user.logo')
    #controls
      numpad(:currency='user.currency')
      tippad
      rates
    button#slide.btn.btn-primary
      i.fa.fa-lg.fa-sort-up
    #payment(style='margin-top: -10px')
      h2
        small Please send
        span#total 0.0
        small.unit {{user.unit}}
      #qr
      h2
        span#address.label.label-success {{user.address}}
    button#received.btn.btn-success(type='button') Payment Received. Thank you!
    audio#success(src='/static/success.wav', hidden='true', enablejavascript='true')
</template>

<script>
import axios from 'axios'
import numpad from './NumPad'
import tippad from './TipPad'
import rates from './Rates'

export default {
  name: 'PaymentRequest',
  components: {
    numpad: numpad,
    tippad: tippad,
    rates: rates
  },
  data () {
    return {
      user: {},
      message: '',
      about: ''
    }
  },
  methods: {
    submit (e) {
      let user = this.$data.user
      e.preventDefault()
      axios.post('/api/login', user).then((res) => {
        this.$router.push('/' + user)
      }).catch(() => {
        this.message = 'Login failed'
      })
    }
  },
  mounted () {
    axios('/api/yy.json').then((res) => {
      this.user = JSON.parse(res.data)
    })
  }
}
</script>

<style lang="stylus">
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

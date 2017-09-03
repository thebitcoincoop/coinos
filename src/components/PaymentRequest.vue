<template lang="pug">
  .payment-request
    h1(v-if='user.title') {{user.title}}
    img(v-if='user.logo')
    numpad(:currency='user.currency', :amount='amount', @update='amount => this.amount = amount')
    tippad(:amount='amount')
    rates
    button#slide.btn.btn-primary
      i.fa.fa-lg.fa-sort-up
    #payment
      h2
        small Please send 
        span {{total}} 
        small {{user.unit}}
      #qr
      h2
        span#address.label.label-success {{user.address}}
    button#received.btn.btn-success(type='button') Payment Received. Thank you!
    audio#success(src='/static/success.wav', hidden='true', enablejavascript='true')
    pre {{amount}}
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
      user: { unit: 'BTC' },
      message: '',
      about: '',
      amount: 0,
      tip: 0,
      total: 0
    }
  },
  computed: {
    total () {
      this.amount * this.user.exchange
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
      margin-top 10px

</style>

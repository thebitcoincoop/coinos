<template lang="pug">
  .payment-request
    h1(v-if='user.title') {{user.title}}
    img(v-if='user.logo')
    numpad(:currency='user.currency', :amount='amount', @update='a => amount = a')
    tippad(:amount='amount', @update='t => tip = t')
    rates(:user='user', @update='r => rate = r')
    #payment
      h2
        small Please send 
        span {{total}} 
        small {{user.unit}}
      canvas#qr
      h2
        span#address.label.label-success {{address}}
    button#received.btn.btn-success(v-if='received') Payment Received. Thank you!
    audio#success(src='/static/success.wav', hidden='true', enablejavascript='true')
</template>

<script>
import axios from 'axios'
import qr from 'qrcode'
import bitcoin from 'bitcoinjs-lib'

import numpad from './NumPad'
import tippad from './TipPad'
import rates from './Rates'

export default {
  components: { numpad, tippad, rates },
  data () {
    return {
      user: {},
      message: '',
      about: '',
      amount: 0,
      tip: 0,
      rate: 0,
      address: '',
      received: false
    }
  },
  computed: {
    total () {
      if (!this.address) return 0
      let total = ((parseFloat(this.amount) / parseFloat(this.rate)) + parseFloat(this.tip)).toFixed(8)
      let canvas = document.getElementById('qr')

      qr.toCanvas(canvas, `bitcoin:${this.address}?amount=${total}`, e => { if (e) console.log(e) })
      canvas.style.height = 300
      canvas.style.width = 300
      return total
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
    axios('/api/yy.json').then(res => {
      this.user = JSON.parse(res.data)
      try {
        bitcoin.address.fromBase58Check(this.user.pubkey)
        this.address = this.user.pubkey
      } catch (e) {
        let master = bitcoin.HDNode.fromBase58(this.user.pubkey)
        let child = master.derive(0).derive(this.user.index)
        this.address = child.getAddress().toString()
      }
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

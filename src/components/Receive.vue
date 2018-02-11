<template lang="pug">
  div
    HCE(:accountNumber='total')
    v-snackbar(:bottom="true" v-model="snackbar" :timeout="1500")
      v-icon info
      span Copied to Clipboard
    template(v-if='generated')
      v-alert(v-if='received' value='received' color='success') Received {{received}} satoshis
      v-layout(v-else)
        v-flex(xs12)
          v-card.pa-3.text-xs-center
            canvas#qr
            v-btn(:data-clipboard-text='payreq' @click.native="snackbar = true")
              v-icon content_copy
            v-btn
              v-icon mdi-cellphone-wireless
      v-btn(@click='generated = false') 
        v-icon.mr-1 arrow_back
        span Back
    template(v-else)
      v-layout(style="max-width: 340px")
        v-flex(xs9)
          numpad(:currency='user.currency', :amount='amount', @update='a => amount = a')
        v-flex(xs3)
          tippad(:amount='amount', @update='t => tip = t')
      div
        span.display-1 {{total}} 
        span.title satoshis
      v-btn(@click='generate') 
        v-icon.mr-1 send
        span Go
</template>

<script>
import axios from 'axios'
import bitcoin from 'bitcoinjs-lib'
import qr from 'qrcode'
import payreq from 'bolt11'
import deepstream from 'deepstream.io-client-js'

import numpad from './NumPad'
import tippad from './TipPad'
import HCE from './HCE'
import Lightning from './Lightning'
import { mapGetters, mapActions } from 'vuex'

const f = parseFloat

export default {
  components: { numpad, tippad, HCE, Lightning },
  data () {
    return {
      message: '',
      about: '',
      amount: 0,
      tip: 0,
      rate: 0,
      address: '1234',
      timeout: null,
      snackbar: false,
      received: 0,
      generated: false,
    }
  },
  computed: {
    ...mapGetters(['user', 'payreq']),

    total () {
      this.received = 0
      return parseInt(((f(this.amount) + f(this.tip)) / this.rate) * 100000000)
    },
  },
  methods: {
    async generate () {
      this.generated = true
      await this.addInvoice(this.total)
      let canvas = document.getElementById('qr')
      qr.toCanvas(canvas, this.payreq, e => { if (e) console.log(e) })
    },

    async loadWallet () {
      let rates = await axios('/rates')
      this.rate = rates.data.ask
    },

    ...mapActions(['addInvoice']),
  },
  mounted () {
    const ds = deepstream('192.168.1.64:6020')
    ds.login()
    const vm = this

    ds.event.subscribe('tx', data => {
      bitcoin.Transaction.fromHex(data).outs.map(o => {
        try {
          let address = bitcoin.address.fromOutputScript(o.script, bitcoin.networks.testnet)
          if (address === this.user.address) {
            this.received = o.value
            var audio = new Audio('/static/success.wav')
            audio.play()
          } 
        } catch(e) { }
      })
    })

    ds.event.subscribe('invoices', data => {
      console.log(data)
      // this.received = data.value
      var audio = new Audio('/static/success.wav')
      audio.play()
    })

    new Clipboard('.btn')
    this.loadWallet()
  }
}
</script>

<style lang="stylus">
  canvas
    position relative
    display block
    height 100%
    margin-left auto
    margin-right auto
</style>

<template lang="pug">
  div
    v-snackbar(:bottom="true" v-model="snackbar" :timeout="1500")
      v-icon info
      | Copied to Clipboard
    v-layout(style="max-width: 320px")
      v-flex(xs9)
        numpad(:currency='user.currency', :amount='amount', @update='a => amount = a')
      v-flex(xs3)
        tippad(:amount='amount', @update='t => tip = t')
    v-alert(v-if='received' value='received' color='success') Received {{received}} satoshis
    v-layout(v-else)
      v-flex(xs12)
        h1 {{total}} sats
        v-card.pa-3
          canvas#qr
          pre {{user.address}}
          v-btn(:data-clipboard-text='payreq' @click.native="snackbar = true")
            v-icon content_copy
          v-btn
            v-icon mdi-cellphone-wireless
</template>

<script>
import axios from 'axios'
import bitcoin from 'bitcoinjs-lib'
import qr from 'qrcode'
import payreq from 'bolt11'
import ds from 'deepstream.io-client-js'

import numpad from './NumPad'
import tippad from './TipPad'
import HCE from './HCE'
import Lightning from './Lightning'
import { mapGetters } from 'vuex'

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
      payreq: {},
      snackbar: false,
      received: 0,
    }
  },
  computed: {
    ...mapGetters(['user']),

    total () {
      this.received = 0
      let total = parseInt((f(this.amount * 100000000) / f(this.rate)) + f(this.tip))

      let time = this.timeout ? 50 : 0
      clearTimeout(this.timeout)
      this.timeout = setTimeout(() => {
        this.payreq = payreq.decode('lnbc20m1pvjluezhp58yjmdan79s6qqdhdzgynm4zwqd5d7xmw5fk98klysy043l2ahrqspp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqfppqw508d6qejxtdg4y5r3zarvary0c5xw7kepvrhrm9s57hejg0p662ur5j5cr03890fa7k2pypgttmh4897d3raaq85a293e9jpuqwl0rnfuwzam7yr8e690nd2ypcq9hlkdwdvycqa0qza8')
        var encoded = payreq.encode({
          "coinType": "bitcoin",
          "satoshis": this.total * 100000000,
          "timestamp": 1496314658,
          "tags": [
            {
              "tagName": "purpose_commit_hash",
              "data": "3925b6f67e2c340036ed12093dd44e0368df1b6ea26c53dbe4811f58fd5db8c1"
            },
            {
              "tagName": "payment_hash",
              "data": "0001020304050607080900010203040506070809000102030405060708090102"
            },
            {
              "tagName": "fallback_address",
              "data": {
                "address": "bc1qw508d6qejxtdg4y5r3zarvary0c5xw7kv8f3t4"
              }
            }
          ]
        })

        var privateKeyHex = 'e126f68f7eafcc8b74f54d269fe206be715000f94dac067d1c04a8ca3b2db734'
        this.payreq = payreq.sign(encoded, privateKeyHex).paymentRequest

        let canvas = document.getElementById('qr')
        qr.toCanvas(canvas, this.payreq, e => { if (e) console.log(e) })

      }, time)

      return total
    },
  },
  methods: {
    async loadWallet () {
      let rates = await axios('/api/rates')
      this.rate = rates.data.ask
    }
  },
  mounted () {
    const client = ds('localhost:6020')
    client.login()
    const vm = this

    client.event.subscribe('tx', data => {
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

    new Clipboard('.btn')
    this.loadWallet()
  }
}
</script>

<style lang="stylus">
  canvas
    position relative
    display block
    width 300
    height 100%
</style>

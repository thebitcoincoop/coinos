<template lang='pug'>
div
  h2 Balance {{balance}}
  v-layout
    v-flex.text-xs-center(xs12)
      v-card.pa-3.text-xs-center
        canvas#qr
        pre {{user.address}}
        v-btn(:data-clipboard-text='user.address' @click.native="snackbar = true")
          v-icon.mr-1 content_copy
          span Copy
      v-btn(v-if='balance > 0')
       v-icon.mr-1(color='yellow') mdi-flash
       span Open Lightning Channel
</template>

<script>
import bitcoin from 'bitcoinjs-lib'
import socketio from 'socket.io-client'
import qr from 'qrcode'
import { mapGetters, mapActions } from 'vuex'

export default {
  data () {
    return {
      playing: false,
      received: 0,
    } 
  },

  computed: {
    ...mapGetters(['user', 'balance']),
  }, 

  methods: {
    ...mapActions(['getBalance']),
  },

  mounted () {
    this.getBalance() 

    const io = socketio('localhost:3000')
    const vm = this

    io.on('tx', data => {
      let tx = bitcoin.Transaction.fromHex(data)
      tx.outs.map(o => {
        try {
          let address = bitcoin.address.fromOutputScript(o.script, bitcoin.networks.testnet)
          if (address === this.user.address) {
            this.received = o.value
            this.getBalance()
          } 
        } catch(e) { }
      })
    })
    new Clipboard('.btn')
    let canvas = document.getElementById('qr')
    qr.toCanvas(canvas, this.user.address, e => { if (e) console.log(e) })
  } 
} 
</script>

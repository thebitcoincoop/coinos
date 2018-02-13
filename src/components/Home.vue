<template lang='pug'>
div
  v-divider
  v-layout
    video(v-if='playing' width='300' height='200' ref='test')
      source(src="static/lightning.mp4" type="video/mp4")
  v-layout
    v-flex(xs12)
      v-card.pa-3.text-xs-center
        canvas#qr
        pre {{user.address}}
        v-btn(:data-clipboard-text='user.address' @click.native="snackbar = true")
          v-icon content_copy
        v-btn
          v-icon mdi-cellphone-wireless
</template>

<script>
import bitcoin from 'bitcoinjs-lib'
import deepstream from 'deepstream.io-client-js'
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
    ...mapGetters(['user']),
  }, 

  methods: {
    start () {
      this.playing = true
      this.$nextTick(() => {
        this.$refs.test.play()
      })
    },
  },

  mounted () {
    const ds = deepstream('192.168.1.64:6020')
    ds.login()
    const vm = this

    ds.event.subscribe('tx', data => {
      console.log(data)
      bitcoin.Transaction.fromHex(data).outs.map(o => {
        try {
          let address = bitcoin.address.fromOutputScript(o.script, bitcoin.networks.testnet)
          if (address === this.user.address) {
            this.received = o.value
            this.start()
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

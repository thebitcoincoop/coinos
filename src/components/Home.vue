<template lang='pug'>
div
  h2 Wallet Balance {{user.balance}}
  v-layout
    v-flex.text-xs-center(xs12)
      v-card.pa-3.text-xs-center
        canvas#qr
        pre {{user.address}}
        v-btn(:data-clipboard-text='user.address' @click.native="snackbar = true")
          v-icon.mr-1 content_copy
          span Copy
      v-btn(v-if='user.balance > 0 && !user.channel' @click='openChannel')
       v-icon.mr-1(color='yellow') mdi-flash
       span Open Lightning Channel
  v-card.mt-2(v-if='user.channel')
    v-card-text
      h2 Channel Balance {{user.channelbalance}}
      span(style='word-wrap: break-word') {{user.channel}}
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
    ...mapGetters(['user']),
  }, 

  methods: {
    ...mapActions(['openChannel', 'getUser']),
  },

  mounted () {
    const io = socketio(process.env.SOCKETIO)
    const vm = this

    io.on('tx', data => {
      console.log(data)
      vm.getUser() 
    })

    new Clipboard('.btn')
    let canvas = document.getElementById('qr')
    qr.toCanvas(canvas, this.user.address, e => { if (e) console.log(e) })
  } 
} 
</script>

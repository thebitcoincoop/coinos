<template lang="pug">
v-container
  h2 Balance: {{balance}}
  h2 Fake Balance: {{fakebalance}}
  v-text-field(label='Invoice' dark v-model='payreq' @input='decode')
  v-list.elevation-1(v-if='payobj')
    v-list-tile
      v-list-tile-title Amount
      v-list-tile-sub-title {{payobj.satoshis}}
    v-list-tile
      v-list-tile-title Recipient
      v-list-tile-sub-title {{payobj.payeeNodeKey | trim}}
    v-list-tile
      v-list-tile-title Date
      v-list-tile-sub-title {{payobj.timestampString}}
  v-btn(@click='scan')
    v-icon.mr-1 camera_alt
    span Scan
  v-btn(v-if='payobj' color="green" dark @click='send')
    v-icon.mr-1 send
    span Pay
</template>

<script>
import Lightning from './Lightning'
import { mapGetters, mapActions } from 'vuex'
import payreq from 'bolt11'

export default {
  components: { Lightning },

  filters: {
    trim (w) {
      return w.substring(0, 12)
    },
  },

  data () {
    return {
      scanresult: '',
      payreq: '',
      payobj: '',
      fakebalance: 2500,
    }
  },

  computed: {
    ...mapGetters(['balance'])
  }, 

  methods: {
    decode () {
      this.payobj = null
      try { 
        this.payobj = payreq.decode(this.payreq)
      } catch (e) {}
    },

    send () {
      this.sendPayment(this.payreq)
    },

    paste () {
      console.log('not implemented')
    },

    scan () {
      this.payreq = payreq.decode('lntb1500n1pd8hmqepp5ckc2xppw56snz2vetuu3sjewugrhutqnpn7227a2yawsregg33aqdyu0v3xgg36yffx2ctyypqhyarfvdkx2w3qvpkxuttsv9ukqgrxdaezqur9dacxcefqw35xzapqwaskuarnypkjytpzdy3r5gn9xucrxvrzxe3z6et9v9sj6dp5v5cz6wfh8ymj6drzvvcxxwpsvcukvwryyf7scqzys20q2tj07gtkv0ru9mhxxw3mnjcknxff55althx742kvhgqz3kk0z38v7gguxzfn0cagls5xz8n85l9xuxxf0nachr4fxxghq68x00mcqetu0aa').paymentRequest
      this.address = this.payreq.payeeNodeKey
      this.amount = this.payreq.satoshis
      this.decode()

      if (typeof window.QRScanner !== 'undefined') {
        window.QRScanner.prepare((err, status) => {
          if (err) {
            console.error(err)
            return
          } 

          window.QRScanner.show((status) => {
            document.querySelector('.application').style.display = 'none'
            window.QRScanner.scan((err, text) => {
              if (err) { 
                console.log(err) 
              } else {
                console.log(text)
                this.scanresult = text
              }

              document.querySelector('.application').style.display = 'block'
              window.QRScanner.hide()
            })
          })
        })
      } 
    },

    ...mapActions(['getBalance', 'sendPayment']),
  },

  mounted () {
    let vm = this
    this.getBalance()

    if (typeof cordova !== 'undefined') {
      window.nfc.addTagDiscoveredListener(event => { vm.fakebalance -= event.tag })
    }
  },
}
</script>

<style lang="stylus">
.small input
  font-size 14px
</style>

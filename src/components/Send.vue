<template lang="pug">
v-container
  h2 Balance: {{balance}}
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
        console.log('meow')
        window.QRScanner.prepare(onDone); // show the prompt
        // Start a scan. Scanning will continue until something is detected or
        // `QRScanner.cancelScan()` is called.
        QRScanner.scan(displayContents);

        function displayContents(err, text){
          if(err){
            // an error occurred, or the scan was canceled (error code `6`)
          } else {
            // The scan completed, display the contents of the QR code:
            this.scanresult = text
          }
        }

        // Make the webview transparent so the video preview is visible behind it.
        QRScanner.show();
        // Be sure to make any opaque HTML elements transparent here to avoid
        // covering the video.
      } 
    },

    ...mapActions(['getBalance', 'sendPayment']),
  },

  mounted () {
    let vm = this
    this.getBalance()

    if (typeof cordova !== 'undefined') {
      window.nfc.addTagDiscoveredListener(event => { vm.balance -= event.tag })
    }

    if (typeof window.QRScanner !== 'undefined') {
      window.QRScanner.prepare(onDone); // show the prompt

      function onDone(err, status){
        if (err) {
         // here we can handle errors and clean up any loose ends.
         console.error(err);
        }
        if (status.authorized) {
          // W00t, you have camera access and the scanner is initialized.
          // QRscanner.show() should feel very fast.
        } else if (status.denied) {
         // The video preview will remain black, and scanning is disabled. We can
         // try to ask the user to change their mind, but we'll have to send them
         // to their device settings with `QRScanner.openSettings()`.
        } else {
          // we didn't get permission, but we didn't get permanently denied. (On
          // Android, a denial isn't permanent unless the user checks the "Don't
          // ask again" box.) We can ask again at the next relevant opportunity.
        }
      }
    } 
  },
}
</script>

<style lang="stylus">
.small input
  font-size 14px
</style>

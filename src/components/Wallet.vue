<template lang="pug">
v-container
  h1 Wallet
  h2 Balance: {{balance}}
  v-btn(@click='scan')
    v-icon camera
  pre {{scanresult}}
</template>

<script>
import Lightning from './Lightning'

export default {
  components: { Lightning },

  data () {
    return {
      scanresult: '',
      balance: 25100,
    }
  },

  methods: {
    scan () {
      console.log('clicked')
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
    }
  },

  mounted () {
    let vm = this

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

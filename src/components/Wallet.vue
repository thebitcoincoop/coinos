<template lang="pug">
div
  h1 Wallet
  h2 Balance: {{balance}}
  pre {{logs}}
</template>

<script>
export default {
  data () {
    return {
      balance: 25100,
      logs: []
    }
  },

  mounted () {
    window.nfc.addNdefListener((nfcEvent) => {
      var tag = nfcEvent.tag
      var ndefMessage = tag.ndefMessage

      // dump the raw json of the message
      // note: real code will need to decode
      // the payload from each record
      this.logs.push(JSON.stringify(ndefMessage))

      // assuming the first record in the message has
      // a payload that can be converted to a string.
      this.logs.push(nfc.bytesToString(ndefMessage[0].payload).substring(3))
    },
    function () { // success callback
      this.logs.push('Waiting for NDEF tag')
    },
    function (error) { // error callback
      this.logs.push('Error adding NDEF listener ' + JSON.stringify(error))
    })
  }
}
</script>

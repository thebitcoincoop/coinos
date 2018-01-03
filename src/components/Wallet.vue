<template lang="pug">
div
  h1 Wallet
  h2 Balance: {{balance}}
</template>

<script>
export default {
  data () {
    return {
      balance: 25100
    }
  },

  mounted () {
    window.nfc.addNdefListener((nfcEvent) => {
      var tag = nfcEvent.tag
      var ndefMessage = tag.ndefMessage

      // dump the raw json of the message
      // note: real code will need to decode
      // the payload from each record
      console.log(JSON.stringify(ndefMessage))

      // assuming the first record in the message has
      // a payload that can be converted to a string.
      console.log(nfc.bytesToString(ndefMessage[0].payload).substring(3))
    },
    function () { // success callback
      console.log('Waiting for NDEF tag')
    },
    function (error) { // error callback
      console.log('Error adding NDEF listener ' + JSON.stringify(error))
    })
  }
}
</script>

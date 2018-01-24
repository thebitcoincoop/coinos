<template lang="pug">
v-container
  h1 Wallet
  h2 Balance: {{balance}}
  lightning
</template>

<script>
import Lightning from './Lightning'

export default {
  components: { Lightning },

  data () {
    return {
      balance: 25100,
    }
  },

  mounted () {
    let vm = this
    if (typeof cordova !== 'undefined') {
      window.nfc.addTagDiscoveredListener(event => { vm.balance -= event.tag })
    }
  },
}
</script>

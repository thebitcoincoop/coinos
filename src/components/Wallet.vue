<template lang="pug">
div
  h1 Wallet
  h2 Balance: {{balance}}
</template>

<script>
export default {
  data () {
    return {
      balance: 25100,
    }
  },

  mounted () {
    window.NativeLogs.getLog(1000, false, logs => console.log(logs))
    let vm = this
    window.nfc.addTagDiscoveredListener(event => { vm.balance -= event.tag })
  },
}
</script>

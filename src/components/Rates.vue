<template lang="pug">
  .rates.tablet
    h2
      small Exchange rate 
      span {{rate}}
      span {{user.symbol}}
      span {{user.commission}}
</template>

<script>
import axios from 'axios'

export default {
  data () {
    return {
      rate: 0
    }
  },
  props: ['user'],
  mounted () {
    axios('https://apiv2.bitcoinaverage.com/exchanges/quadrigacx').then(res => {
      this.rate = res.data.symbols.BTCCAD.ask
      this.$emit('update', this.rate)
    })
  }
}
</script>

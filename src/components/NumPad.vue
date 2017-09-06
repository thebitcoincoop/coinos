<template lang="pug">
  .numpad.pull-left
    h2
      span.amount {{ amount }}
      small.currency {{ currency }}
    button.btn.btn-lg.btn-default(v-for='i in buttons' @click='update') {{i}}
    br(v-for='i in buttons' v-if='i + 1 % 3 == 0')
</template>

<script>
export default {
  props: ['currency', 'amount'],
  data () {
    return {
      buttons: [...Array(9).keys(), '<', '0', 'C']
    }
  },
  methods: {
    update (e) {
      let amount = parseFloat(this.amount)
      let m = e.target.innerHTML

      if (m === '&lt;') {
        amount = (Math.floor(100 * (parseFloat(amount) / 10)) / 100)
      } else if (amount < 10000000) {
        if (m === '00') {
          amount = 100 * amount
        } else {
          amount = 10 * amount + parseFloat(m) / 100
        }
      }

      if (m === 'C') {
        amount = 0
      }

      amount = amount.toFixed(2)
      this.$emit('update', amount)
    }
  },
  mounted () {
    console.log([...Array(9).keys()])
  }
}
</script>

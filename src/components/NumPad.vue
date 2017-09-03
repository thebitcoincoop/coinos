<template lang="pug">
  .numpad.pull-left
    h2
      span.amount {{ amount }}
      small.currency {{ currency }}
    button.btn.btn-lg.btn-default(@click='update') 1
    button.btn.btn-lg.btn-default(@click='update') 2
    button.btn.btn-lg.btn-default(@click='update') 3
    br
    button.btn.btn-lg.btn-default(@click='update') 4
    button.btn.btn-lg.btn-default(@click='update') 5
    button.btn.btn-lg.btn-default(@click='update') 6
    br
    button.btn.btn-lg.btn-default(@click='update') 7
    button.btn.btn-lg.btn-default(@click='update') 8
    button.btn.btn-lg.btn-default(@click='update') 9
    br
    button.btn.btn-lg.btn-default(@click='update') C
    button.btn.btn-lg.btn-default(@click='update') 0
    button.btn.btn-lg.btn-default(@click='update') <
</template>

<script>
export default {
  props: ['currency', 'amount'],
  methods: {
    update (e) {
      let amount = this.amount
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
  mounted () {}
}
</script>

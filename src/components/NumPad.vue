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
  name: 'PaymentRequest',
  props: ['currency'],
  data () {
    return {
      amount: '0.0'
    }
  },
  methods: {
    update (e) {
      let m = e.target.innerHTML
      if (m === 'C') {
        this.amount = (0).toFixed(2)
        return
      }
      if (m === '&lt;') {
        console.log('yatta')
        this.amount = (Math.floor(100 * (parseFloat(this.amount) / 10)) / 100).toFixed(2)
        return
      }
      if (this.amount > 10000000) {
        return
      }
      if (m === '00') {
        this.amount = 100 * this.amount
      } else {
        this.amount = 10 * this.amount + parseFloat(m) / 100
      }

      this.amount = this.amount.toFixed(2)
    }
  },
  mounted () {}
}
</script>

<template lang="pug">
.tippad.tablet
  h2
    small + 
    span.tip {{total}}
  button.active.btn.btn-lg.btn-default(type='button', @click='tip = 0') No Tip
  br
  button.btn.btn-lg.btn-default(type='button', @click='tip = 10') +10%
  br
  button.btn.btn-lg.btn-default(type='button', @click='tip = 15') +15%
  br
  button.btn.btn-lg.btn-default(type='button', @click='tip = 20') +20%
</template>

<script>
export default {
  props: ['amount'],
  data () {
    return {
      tips: [0, 10, 15, 20],
      tip: 0
    }
  },
  computed: {
    total () {
      return (this.tip * this.amount * 0.01).toFixed(2)
    }
  }
}
</script>

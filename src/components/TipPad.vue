<template lang="pug">
.tippad.tablet
  h2
    small + 
    span.tip {{tip}}
  button.btn.btn-lg.btn-default(:class='{ active: percent == 0 }', type='button', @click='percent = 0') No Tip
  br
  button.btn.btn-lg.btn-default(:class='{ active: percent == 10 }', type='button', @click='percent = 10') +10%
  br
  button.btn.btn-lg.btn-default(:class='{ active: percent == 15 }', type='button', @click='percent = 15') +15%
  br
  button.btn.btn-lg.btn-default(:class='{ active: percent == 20 }', type='button', @click='percent = 20') +20%
</template>

<script>
export default {
  props: ['amount'],
  data () {
    return {
      percent: 0
    }
  },
  computed: {
    tip () {
      let tip = (this.percent * this.amount * 0.01).toFixed(2)
      this.$emit('update', tip)
      return tip
    }
  }
}
</script>

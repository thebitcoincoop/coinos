<template lang="pug">
div
  span.display-1 {{tip}}
  v-layout
    v-flex
      v-btn(:class='{ active: percent == -1 }' @click='percent = 0') No Tip
      v-btn(:class='{ active: percent == 10 }' @click='percent = 10') +10%
      v-btn(:class='{ active: percent == 15 }' @click='percent = 15') +15%
      v-btn(:class='{ active: percent == 20 }' @click='percent = 20') +20%
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

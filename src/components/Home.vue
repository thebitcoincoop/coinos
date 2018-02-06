<template lang='pug'>
div
  v-btn(@click='start')
    v-icon launch
  v-divider
  v-layout
    div
      video(v-if='playing' width='300' height='200' @ended='finish' ref='test')
        source(src="static/lightning.mp4" type="video/mp4")
</template>

<script>
export default {
  data () {
    return {
      playing: false,
    } 
  },
  methods: {
    start () {
      this.playing = true
      this.$nextTick(() => {
        this.$refs.test.play()
      })
    },
    finish () {
      this.playing = false
    } 
  } 
} 
</script>

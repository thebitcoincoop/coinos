<template lang="pug">
div
  .logo
  form(@submit='submit')
    input.form-control(v-model='username', type='text', placeholder='Username', autofocus)
    br
    input.form-control(v-model='password', type='password', placeholder='Password', required)
    br
    button.btn.btn-lg.btn-primary.btn-block(type='submit') Sign in
  p
    a.btn.btn-lg.btn-secondary.btn-block(href='/signup') Register
  p
    a(href='http://bitcoincoop.org/coinos') What is this?
</template>

<script>
import axios from 'axios'

export default {
  name: 'home',
  data () {
    return {
      username: 'yy',
      password: 'pw'
    }
  },
  methods: {
    submit (e) {
      e.preventDefault()
      axios.post('/api/login', this.$data).then((res) => {
        console.log(res)
      })
    }
  }
}
</script>

<style lang="stylus" scoped>
  .logo
    background-image url('/static/img/coinos_logo.png')
    width 300px
    height 80px
    margin-top 10px
    margin-bottom 10px

  form
    margin-bottom 10px
    .form-control
      height auto
      -webkit-box-sizing border-box
      -moz-box-sizing border-box
      box-sizing border-box
      padding 10px
      font-size 16px

  .notice
    border 1px solid gray
    background #eee
    padding 10px
    margin-bottom 15px

  .btn
    background #ccc
    display block
</style>

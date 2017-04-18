<template lang="pug">
div
  .logo
  .alert.alert-danger(v-if='message') {{message}}
  form(@submit='submit')
    input.form-control(v-model='user.username', type='text', placeholder='Username', autofocus)
    input.form-control(v-model='user.password', type='password', placeholder='Password', required)
    button.btn.btn-lg.btn-primary.btn-block(type='submit') Sign in
  p
    router-link.btn.btn-lg.btn-secondary.btn-block(to='/register') Register
  about(v-if='about')
  p(v-else)
    a(@click='about = true') What is this?
</template>

<script>
import axios from 'axios'
import about from './About'

export default {
  name: 'home',
  data () {
    return {
      user: {
        username: 'yy',
        password: 'pw'
      },
      message: '',
      about: ''
    }
  },
  components: {
    about: about
  },
  methods: {
    submit (e) {
      let user = this.$data.user
      e.preventDefault()
      axios.post('/api/login', user).then((res) => {
        this.$router.push(user.username)
      }).catch(() => {
        this.message = 'Login failed'
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
    margin-bottom 20px

  form
    .form-control
      height auto
      -webkit-box-sizing border-box
      -moz-box-sizing border-box
      box-sizing border-box
      padding 10px
      font-size 16px
      margin-bottom 10px

  .notice
    border 1px solid gray
    background #eee
    padding 10px
    margin-bottom 15px

  .btn
    display block

  .btn-secondary
    background #333
    color white
    &:hover
      background #222
</style>

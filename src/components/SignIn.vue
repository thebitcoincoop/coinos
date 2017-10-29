<template lang="pug">
v-container
  p.text-xs-center.py-5.logo

  v-alert(color='error' v-if='message') {{message}}
  v-alert(color='success' v-if='logout') You've been logged out
  v-form(@submit='submit')
    v-text-field(label="Username" v-model='user.username' autofocus)
    v-text-field(label="Password" v-model='user.password' type='password')
    v-btn(type='submit') Sign in
    v-btn(@click='$router.push("/register")') Register
</template>

<script>
export default {
  props: ['logout'],
  data () {
    return {
      user: {
        username: 'yy',
        password: 'pw'
      },
      message: ''
    }
  },
  methods: {
    submit (e) {
      let user = this.$data.user
      e.preventDefault()
      this.axios.post('/api/login', user).then((res) => {
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
</style>

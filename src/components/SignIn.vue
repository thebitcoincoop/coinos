<template lang="pug">
v-layout
  v-flex(xs3 offset-xs3)
    v-alert(color='error' v-if='message') {{message}}
    v-alert(color='success' v-if='logout') You've been logged out
    v-form(@submit='submit')
      v-text-field(label="Username" v-model='user.username' autofocus dark)
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
    async submit (e) {
      let user = this.$data.user
      e.preventDefault()
      try {
        let res = await this.axios.post('/api/login', user)
        this.$store.commit('SET_USER', res.data.user)
        this.$router.push('/' + res.data.user.username)
      } catch (e) {
        this.message = 'Login failed'
        console.log(e)
      }
    }
  }
}
</script>

<style lang="stylus" scoped>
  .logo
    background-image url('/static/img/coinos_logo.png')
</style>

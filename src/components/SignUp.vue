<template lang="pug">
div
  #main-logo
  .alert.alert-danger(v-if='error')
    | {{error}}
  form(v-on:submit='submit')
    .form-group
      label(for='username') Username:
      input.form-control(v-model='username')
    .form-group
      label(for='email') Email:
      input.form-control(v-model='email')
    .form-group
      label(for='password') Passphrase:
      input.form-control(v-model='password', type='password')
    .form-group
      label(for='confirm') Confirm Passphrase:
      input.form-control(v-model='passconfirm', type='password')
    input(v-model='commission', type='hidden', value='0')
    input(v-model='unit', type='hidden')
    input(v-model='pubkey', type='hidden')
    input(v-model='privkey', type='hidden')
    input.btn.btn-primary(type='submit', value='Register')
</template>

<script>
export default {
  name: 'SignUp',
  data () {
    return {
      username: '',
      email: 'asoltys@gmail.com',
      password: '',
      passconfirm: '',
      unit: 'BTC',
      commission: '',
      pubkey: '',
      privkey: '',
      error: ''
    }
  },
  methods: {
    submit (e) {
      e.preventDefault()
      this.$http.post('/api/users', this.$data).then(response => {
        this.$router.go(this.username)
      }).catch(e => {
        this.error = e.body.message
      })
    }
  }
}
</script>

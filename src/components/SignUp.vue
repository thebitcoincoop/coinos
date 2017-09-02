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
  import bip39 from 'bip39'
  import bitcoin from 'bitcoinjs-lib'
  import AES from 'crypto-js/aes'

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
      async submit (e) {
        e.preventDefault()
        try {
          await this.$http.post('/api/users', this.$data)
          this.$router.go(this.username)
        } catch (e) {
          this.error = e.body.message
        }
      }
    },
    mounted () {
      let mnemonic = bip39.generateMnemonic()
      let key = bitcoin.HDNode.fromSeedBuffer(bip39.mnemonicToSeed(mnemonic)).deriveHardened(44).deriveHardened(0)
      this.pubkey = key.neutered().toBase58()
      this.privkey = AES.encrypt(key.toString(), this.password).toString()
    }
  }
</script>

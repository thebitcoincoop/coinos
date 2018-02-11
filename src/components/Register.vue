<template lang="pug">
v-layout
  v-flex(xs12 md3)
    v-alert(v-if='error') {{error}}
    v-form(@submit='submit')
      v-text-field(label='Username' v-model='username')
      v-text-field(label='Email' v-model='email')
      v-text-field(label='Passphrase' v-model='password')
      v-text-field(label='Confirm' v-model='passconfirm')
      v-btn(type='submit') Register
</template>

<script>
  import bip39 from 'bip39'
  import bitcoin from 'bitcoinjs-lib'
  import AES from 'crypto-js/aes'

  export default {
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
          await this.$http.post('/users', this.$data)
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

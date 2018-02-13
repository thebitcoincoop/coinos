<template lang="pug">
v-layout
  v-flex(xs12 md3)
    v-alert(v-if='error') {{error}}
    v-form(@submit='submit')
      v-text-field(label='Username' v-model='user.username')
      v-text-field(label='Email' v-model='user.email')
      v-text-field(label='Passphrase' v-model='user.password')
      v-text-field(label='Confirm' v-model='user.passconfirm')
      v-btn(type='submit') Register
</template>

<script>
  import bip39 from 'bip39'
  import bitcoin from 'bitcoinjs-lib'
  import AES from 'crypto-js/aes'
  import { mapActions } from 'vuex'

  export default {
    data () {
      return {
        user: {
          username: '',
          email: 'asoltys@gmail.com',
          password: '',
          passconfirm: '',
          unit: 'BTC',
          commission: '',
          pubkey: '',
          privkey: '',
        }, 
        error: '',
      }
    },

    methods: {
      async submit (e) {
        e.preventDefault()
        this.createUser(this.user)
      },

      ...mapActions(['createUser']),
    },

    mounted () {
      let mnemonic = bip39.generateMnemonic()
      let key = bitcoin.HDNode.fromSeedBuffer(bip39.mnemonicToSeed(mnemonic)).deriveHardened(44).deriveHardened(0)
      this.user.pubkey = key.neutered().toBase58()
      this.user.privkey = AES.encrypt(key.toString(), this.user.password).toString()
    }
  }
</script>

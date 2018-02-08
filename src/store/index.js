import apolloClient from '../apollo-client'
import Vue from 'vue'
import Vuex from 'vuex'
import bitcoin from 'bitcoinjs-lib'
import bip39 from 'bip39'
import transactionsQuery from '../graphql/transactions.gql'
// import ds from 'deepstream.io-client-js'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    user: {},
    transactions: {},
    balance: 0,
  },
  actions: {
    async getTransactions ({ commit }) {
      let res = await apolloClient.query({
        query: transactionsQuery,
        fetchPolicy: 'network-only',
      })

      commit('SET_TRANSACTIONS', res.data.transactions)
    },

    async getBalance ({ commit }) {
      let res = await Vue.axios.get('/api/balance')

      commit('SET_BALANCE', res.data.balance)
    },

    async sendPayment ({ commit }, payreq) {
      let res = await Vue.axios.post('/api/sendPayment', { payreq })
      /*
      const client = ds('localhost:6020')
      client.login()
      client.event.emit('payment', payreq)
      */
    },
  },
  mutations: {
    SET_USER (s, v) { s.user = v },
    SET_TRANSACTIONS (s, v) { s.transactions = v },
    SET_BALANCE (s, v) { s.balance = v },
  },
  getters: {
    user: s => {
      let mnemonic = bip39.generateMnemonic()
      let key = bitcoin.HDNode.fromSeedBuffer(bip39.mnemonicToSeed(mnemonic), bitcoin.networks.testnet).deriveHardened(44).deriveHardened(0)
      let child = key.derive(0).derive(0)
      s.user.address = child.getAddress().toString()
      return s.user
    },
    transactions: s => s.transactions,
    balance: s => s.balance,
  },
})

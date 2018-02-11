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
    user: null,
    transactions: {},
    balance: 0,
    payreq: '',
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
      let res = await Vue.axios.get('/balance')

      commit('SET_BALANCE', res.data.balance)
    },

    async sendPayment ({ commit }, payreq) {
      await Vue.axios.post('/sendPayment', { payreq })
    },

    async addInvoice ({ commit }, amount) {
      let res = await Vue.axios.post('/addInvoice', { amount })

      commit('SET_PAYREQ', res.data.payment_request)
    },
  },
  mutations: {
    SET_USER (s, v) { s.user = v },
    SET_TRANSACTIONS (s, v) { s.transactions = v },
    SET_BALANCE (s, v) { s.balance = v },
    SET_PAYREQ (s, v) { s.payreq = v },
  },
  getters: {
    user: s => {
      if (!s.user || !s.user.address) {
        return null
      } 

      s.user.address = 'mjWfuh2vYua3UWuYEtkBdNpxf94EMyMC9y'

      /*
      let mnemonic = bip39.generateMnemonic()
      let seed = bip39.mnemonicToSeed(mnemonic)
      let key = bitcoin.HDNode.fromSeedBuffer(seed, bitcoin.networks.testnet).deriveHardened(44).deriveHardened(0)
      let child = key.derive(0).derive(0)
      s.user.address = child.getAddress().toString()
      */

      return s.user
    },
    transactions: s => s.transactions,
    balance: s => s.balance,
    payreq: s => s.payreq,
  },
})

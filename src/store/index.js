import apolloClient from '../apollo-client'
import Vue from 'vue'
import Vuex from 'vuex'
import bitcoin from 'bitcoinjs-lib'
import bip39 from 'bip39'
import transactionsQuery from '../graphql/transactions.gql'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    user: {},
    transactions: {},
  },
  actions: {
    async getTransactions ({ commit }) {
      let res = await apolloClient.query({
        query: transactionsQuery,
        fetchPolicy: 'network-only',
      })

      commit('SET_TRANSACTIONS', res.data.transactions)
    },
  },
  mutations: {
    SET_USER (s, v) { s.user = v },
    SET_TRANSACTIONS (s, v) { s.transactions = v },
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
  },
})

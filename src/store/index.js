import Vue from 'vue'
import Vuex from 'vuex'
import bitcoin from 'bitcoinjs-lib'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    user: {},
  },
  mutations: {
    SET_USER (s, v) { s.user = v },
  },
  getters: {
    user: s => {
      let master = bitcoin.HDNode.fromBase58(s.user.pubkey)
      let child = master.derive(0).derive(s.user.index)
      s.user.address = child.getAddress().toString()
      return s.user
    },
  },
})

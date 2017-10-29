import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    user: 'yy'
  },
  mutations: {
    login (state, user) {
      state.user = user
    }
  }
})

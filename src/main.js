import Vue from 'vue'
import Vuetify from 'vuetify'
import VueAxios from 'vue-axios'
import Axios from 'axios'
import App from './App'
import Styles from './assets/styles.styl'
import router from './router'
import store from './store'

Vue.use(VueAxios, Axios)
Vue.use(Vuetify)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  template: '<app/>',
  components: { App, Styles },
  router,
  store
})

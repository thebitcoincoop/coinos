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

var tag = document.createElement('script')

document.addEventListener('deviceready', function () {
  Vue.prototype.$cordova = cordova
}, false)

tag.type = 'text/javascript'
document.body.appendChild(tag)
tag.src = 'cordova.js'

/* eslint-disable no-new */
new Vue({
  components: { App, Styles },
  el: '#app',
  template: '<app/>',
  router,
  store,
})

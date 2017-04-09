import Vue from 'vue'
import VueRouter from 'vue-router'
import App from './App'
import SignIn from './components/SignIn'
import SignUp from './components/SignUp'
import Sales from './components/Sales'
import Account from './components/Account'
import Settings from './components/Settings'

const routes = [
  { path: '/', component: SignIn },
  { path: '/signin', component: SignIn },
  { path: '/signup', component: SignUp },
  { path: '/sales', component: Sales },
  { path: '/account', component: Account },
  { path: '/settings', component: Settings }
]

const router = new VueRouter({
  mode: 'history',
  routes: routes,
  scrollBehavior: function (to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return { x: 0, y: 0 }
    }
  }
})

Vue.use(VueRouter)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  template: '<app/>',
  components: { App },
  router: router
})

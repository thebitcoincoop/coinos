import Vue from 'vue'
import VueRouter from 'vue-router'
import SignIn from '../components/SignIn'
import SignUp from '../components/SignUp'
import Sales from '../components/Sales'
import Wallet from '../components/Wallet'
import Account from '../components/Account'
import Settings from '../components/Settings'
import About from '../components/About'
import PaymentRequest from '../components/PaymentRequest'

const routes = [
  { path: '/', component: SignIn, props: { logout: false } },
  { path: '/register', component: SignUp },
  { path: '/sales', component: Sales },
  { path: '/wallet', component: Wallet },
  { path: '/account', component: Account },
  { path: '/settings', component: Settings },
  { path: '/about', component: About },
  { path: '/logout', component: SignIn, props: { logout: true } },
  { path: '/:user', component: PaymentRequest }
]

Vue.use(VueRouter)

export default new VueRouter({
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

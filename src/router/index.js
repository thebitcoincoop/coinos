import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../components/Home'
import SignIn from '../components/SignIn'
import SignUp from '../components/SignUp'
import Payments from '../components/Payments'
import Send from '../components/Send'
import Receive from '../components/Receive'
import Account from '../components/Account'
import Settings from '../components/Settings'
import About from '../components/About'

const routes = [
  { path: '/', component: SignIn, props: { logout: false } },
  { path: '/register', component: SignUp },
  { path: '/payments', component: Payments },
  { path: '/send', component: Send },
  { path: '/receive', component: Receive },
  { path: '/account', component: Account },
  { path: '/settings', component: Settings },
  { path: '/about', component: About },
  { path: '/logout', component: SignIn, props: { logout: true } },
  { path: '/:user', component: Home },
]

Vue.use(VueRouter)

export default new VueRouter({
  mode: 'hash',
  routes: routes,
  scrollBehavior: function (to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return { x: 0, y: 0 }
    }
  },
})

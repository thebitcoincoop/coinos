<template lang="pug">
  v-app(dark)
    v-toolbar(app dark color="primary" clipped-left fixed)
      v-toolbar-side-icon(v-if='user' @click.stop='toggleMenu')
      v-toolbar-title(dark @click='$router.push("/")')
        img.logo(src='static/img/coinos_logo.png')
      v-spacer
      v-speed-dial(direction='bottom' transition='slide-y-transition')
        v-btn(slot='activator' icon @click='$router.push("/about")')
          v-icon(color='yellow') mdi-flash
        v-avatar
          img.fx(src='static/img/bitcoin.png')
        v-avatar
          img.fx(src='static/img/litecoin.png')
        v-avatar
          img.fx(src='static/img/dogecoin.png')
      v-btn(icon @click='$router.push("/logout")')
        v-icon power_settings_new
    v-navigation-drawer.primary(v-if='user' v-model='drawer' enable-resize-watcher app clipped)
      v-list.secondary
        template(v-for='i in menu') 
          v-list-tile(:key='i.route' ripple @click='$router.push(i.route)')
            v-list-tile-action
              v-btn(icon ripple)
                v-icon {{i.icon}}
            v-list-tile-content {{i.content}}
    v-content
      v-container.pl-2(fluid)
        transition(name='fade')
          router-view
    v-footer(app)
      v-bottom-nav(absolute style="height: 60px; margin-bottom: 55px")
        v-btn(flat dark @click="$router.push('/receive')")
          span Receive
          v-icon mdi-arrow-left-bold-box
        v-btn(flat dark @click="scan")
          span Scan
          v-icon camera_alt
        v-btn(flat dark @click="$router.push('/send')")
          span Send
          v-icon mdi-send
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters(['user']),
  }, 

  data () {
    return {
      drawer: false,
      menu: [
        { route: 'home', content: 'Home', icon: 'home' },
        { route: 'send', content: 'Send', icon: 'mdi-send' },
        { route: 'receive', content: 'Receive', icon: 'mdi-arrow-left-bold-box' },
        { route: 'payments', content: 'Payments', icon: 'assignment' },
        { route: 'account', content: 'Account', icon: 'person' },
        { route: 'settings', content: 'Settings', icon: 'settings' },
        { route: 'logout', content: 'Logout', icon: 'power_settings_new' }
      ]
    }
  },

  watch: {
    $route (route) {
      this.authenticate(route)
    },
  },

  methods: {
    readCookie (n) {
      let a = `; ${document.cookie}`.match(`;\\s*${n}=([^;]+)`);
      return a ? a[1] : '';
    },

    scan () {
      console.log(window.QRScanner)
    }, 

    toggleMenu () {
      this.drawer = !this.drawer
    },

    authenticate (route) {
      const publicpaths = ['/login', '/about', '/register']
      if (!publicpaths.includes(route.path) && !this.user) {
        this.$router.push('/login')
      }
    },
  },

  async created () {
    this.authenticate(this.$route)
  },

  mounted () {
    console.log(document.cookie)
  },
}
</script> 

<style lang="stylus">
.toolbar__title
  cursor pointer

.fade-transition
  &-leave-active
    position: absolute
 
  &-enter-active, &-leave, &-leave-to
    transition: $primary-transition
 
  &-enter, &-leave-to
    opacity: 0

img.logo
  max-height 40px

img.fx
  width 30px
  height 30px
</style>

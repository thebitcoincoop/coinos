<template lang="pug">
  v-app(dark)
    v-toolbar(app dark color="primary" clipped-left fixed)
      v-toolbar-side-icon(@click.stop='toggleMenu')
      v-toolbar-title(dark @click='$router.push("/")')
        img.logo(src='static/img/coinos_logo.png')
      v-spacer
      v-btn(icon @click='$router.push("/logout")')
        v-icon(color='yellow') mdi-flash
      v-btn(icon @click='$router.push("/logout")')
        v-icon power_settings_new
    v-navigation-drawer.primary(v-model='drawer' enable-resize-watcher app clipped)
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
        v-btn(flat dark @click="$router.push('/home')") 
          span Home
          v-icon home
        v-btn(flat dark @click="$router.push('/send')")
          span Send
          v-icon mdi-send
</template>

<script>
export default {
  name: 'app',
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
  methods: {
    toggleMenu () {
      this.drawer = !this.drawer
    }
  }
}
</script> 

<style lang="stylus">
@require '../node_modules/vuetify/dist/vuetify.min.css'

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
</style>

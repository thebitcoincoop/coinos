<template lang="pug">
  v-app
    v-toolbar(app dark color="primary" clipped-left fixed)
      v-toolbar-side-icon(@click.stop='toggleMenu')
      v-toolbar-title(dark @click='$router.push("/")') CoinOS
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
    v-footer(app color='white')
      v-layout(row wrap)
        v-flex(xs12)
</template>

<script>
export default {
  name: 'app',
  data () {
    return {
      drawer: false,
      menu: [
        { route: 'home', content: 'Home', icon: 'home' },
        { route: 'sales', content: 'Sales', icon: 'assignment' },
        { route: 'wallet', content: 'Wallet', icon: 'lock' },
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
@require '../node_modules/mdi/css/materialdesignicons.min.css'

.toolbar__title
  cursor pointer

.fade-transition
  &-leave-active
    position: absolute
 
  &-enter-active, &-leave, &-leave-to
    transition: $primary-transition
 
  &-enter, &-leave-to
    opacity: 0
</style>

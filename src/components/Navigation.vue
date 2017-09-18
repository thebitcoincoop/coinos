<template lang="pug">
nav.navbar(role='navigation')
  button.btn.btn-primary.navbar-toggle(type='button', data-toggle='collapse', data-target='#nav')
    span.pull-right.glyphicon.glyphicon-list
  #nav.collapse.navbar-collapse.no-transition
    .navbar
      ul.nav.navbar-nav
        li(v-for='l in links')
          router-link(:to='l.route' @click.native='click')
            span(:class='"glyphicon glyphicon-" + l.icon')  {{l.title}}
</template>

<script>
export default {
  data () {
    return {
      links: [
        { route: 'home', title: 'Home', icon: 'home' },
        { route: 'sales', title: 'Sales', icon: 'list-alt' },
        { route: 'wallet', title: 'Wallet', icon: 'lock' },
        { route: 'account', title: 'Account', icon: 'user' },
        { route: 'settings', title: 'Setting', icon: 'cog' },
        { route: 'logout', title: 'Logout', icon: 'off' }
      ]
    }
  },
  methods: {
    click () {
      document.querySelector('.navbar-toggle').click()
    }
  }
}
</script>

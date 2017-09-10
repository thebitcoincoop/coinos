<template lang="pug">
nav.navbar(role='navigation')
  button.btn.btn-primary.navbar-toggle(type='button', data-toggle='collapse', data-target='#nav')
    span.pull-right.glyphicon.glyphicon-list
    |  
    span.pull-right.glyphicon.glyphicon-exclamation-sign
  #nav.collapse.navbar-collapse.no-transition
    .navbar
      ul.nav.navbar-nav
        li
          router-link(to='home')
            span.glyphicon.glyphicon-home
            |  Home
        li
          router-link(to='sales')
            span.glyphicon.glyphicon-list-alt
            |  Sales
        li
          router-link(to='wallet')
            span.fa.fa-bank
            |  Wallet
        li
          router-link(to='account')
            span.glyphicon.glyphicon-user
            |  Account
        li
          router-link(to='settings')
            span.glyphicon.glyphicon-cog
            |  Settings
        li
          router-link(to='logout')
            span.glyphicon.glyphicon-off
            |  Logout
</template>

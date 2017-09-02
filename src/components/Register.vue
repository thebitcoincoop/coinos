<template lang="pug">
div
  #main-logo
  form(action='/users', method='post')
    .form-group
      label(for='username') Username:
      input(type='text', name='username')
    .form-group
      label(for='email') Email:
      input(type='text', name='email')
    .form-group
      label(for='password') Passphrase:
      input(type='password', name='password')
      #messages
    .form-group
      label(for='confirm') Confirm Passphrase:
      input(type='password', name='confirm')
    input(name='commission', type='hidden', value='0')
    input(name='unit', type='hidden', value='BTC')
    input(name='pubkey', type='hidden')
    input(name='privkey', type='hidden')
    input.btn.btn-primary(type='submit', value='Register')
</template>

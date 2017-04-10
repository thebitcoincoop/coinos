<template lang="pug">
div
  #main-logo
  form.form-signin(action='login', method='post')
    input.form-control(name='username', type='text', placeholder='Username', value='user', required='', autofocus='')
    br
    |  
    input.form-control(name='password', type='password', placeholder='Password', required='')
    br
    |  
    button.btn.btn-lg.btn-primary.btn-block(type='submit') Sign in
  p
    a.btn.btn-lg.btn-secondary.btn-block(href='/signup') Register
  p
    a(href='http://bitcoincoop.org/coinos') What is this?
</template>

<script>
export default {
  name: 'home'
}
</script>

<style lang="stylus" scoped>
  #main-logo
    margin-bottom 15px

  .form-signin
    margin-bottom 10px
    .form-control
      height auto
      -webkit-box-sizing border-box
      -moz-box-sizing border-box
      box-sizing border-box
      padding 10px
      font-size 16px

  .notice
    border 1px solid gray
    background #eee
    padding 10px
    margin-bottom 15px

  .btn
    background #ccc
    display block
</style>

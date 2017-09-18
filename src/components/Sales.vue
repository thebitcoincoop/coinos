<template lang="pug">
  div
    h1 Payments Received
    .controls
      button#from.btn.btn-primary {{from|format}}
      |  to 
      button#to.btn.btn-primary(name='to') {{to|format}}
    p.alert.alert-warning(v-if='!transactions.length') No transactions were found for the specified time period
    table.table.table-striped.table-hover(v-if='transactions.length')
      thead
        tr
          th Time
          th Rate
          th &nbsp;&nbsp;&nbsp;BTC
          th &nbsp;&nbsp;&nbsp;{{currency}}
      tbody
      tfoot
        tr
          td.total(colspan='2') Subtotal:
          td {{subtotal}}
          td {{subtotal|fiat}}
        tr
          td.total(colspan='2') Tips:
          td {{tips}}
          td {{tips|fiat}}
        tr
          td.total(colspan='2') Total:
          td {{total}}
          td {{total|fiat}}
    #modal.modal.fade(tabindex='-1', role='dialog')
      .modal-dialog
        .modal-content
          .modal-header
            button.close(type='button', data-dismiss='modal')
              span(aria-hidden='true') &times;
              span.sr-only Close
            h4.modal-title Transaction
          .modal-body
            textarea(style='width: 100%; height: 100px;', placeholder='Notes')
            p#yousure You sure?
          .modal-footer
            #buttons
              button.btn.btn-danger(type='button', tabindex='-1') Delete Transaction
              button.btn.btn-primary(type='button') View Blockchain
              button.btn.btn-default(type='button', data-dismiss='modal') Done
            #confirm
              button.btn.btn-default(type='button', data-dismiss='modal') No
              button.btn.btn-danger(type='button') Yes
</template>

<script>
import axios from 'axios'
import moment from 'moment'
export default {
  data () {
    return {
      currency: 'CAD',
      subtotal: 0,
      total: 0,
      tips: 0,
      from: moment().subtract(7, 'days'),
      to: moment(),
      transactions: []
    }
  },
  filters: {
    format (date) {
      return date.format('MMMM DD, YYYY')
    },
    fiat (amount) {
      return amount * 6000
    }
  },
  mounted () {
    axios.get('/api/yy/transactions', d => { this.transactions = d.transactions })
  }
}
</script>

<style lang="stylus">
input
  position relative 
  top 25px
  height 0px
  width 0px
  border 0px

.controls 
  margin-bottom 15px

table
  cursor pointer
</style>

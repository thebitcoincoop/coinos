<template lang="pug">
  v-list
    v-list-tile(v-for='tx in transactions')
      v-subheader {{tx.date | format}}
      v-list-tile-content
        v-list-tile-title {{tx.amount}}
</template>

<script>
import moment from 'moment'
import { mapGetters } from 'vuex'

export default {
  data () {
    return {
      currency: 'CAD',
      subtotal: 0,
      total: 0,
      tips: 0,
      from: moment().subtract(7, 'days'),
      to: moment(),
    }
  },
  computed: {
    ...mapGetters(['transactions'])
  },
  filters: {
    format (date) {
      return moment(date).format('MMM D YYYY')
    },
    fiat (amount) {
      return amount * 6000
    }
  },
  mounted () {
    this.$store.dispatch('getTransactions')
  } 
}
</script>

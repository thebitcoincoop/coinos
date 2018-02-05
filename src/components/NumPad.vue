<template lang="pug">
.numpad
  span.display-1 {{ amount }}
    template(v-for='i in buttons.length / 3')
      v-layout(row)
        v-flex(v-for='j in 3' xs4)
          v-btn(@click='update', :id='id(j * i + 1)') 
            template(v-if='buttons[j + 3 * i - 4] !== "<"')
              | {{buttons[j + 3 * i - 4]}}
            v-icon(v-else) undo

</template>

<script>
export default {
  props: ['currency', 'amount'],
  data () {
    return {
      buttons: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '<', '0', 'C'],
      codes: Array.from(Array(10), (_, x) => x + 48)
    }
  },
  methods: {
    id (i) {
      let prefix = 'button-'
      if (i === '<') return prefix + 'lt'
      return prefix + i
    },
    keyup (e) {
      let key = e.keyCode
      if (key > 56) key -= 48
      let id = this.codes.indexOf(key)
      if (key === 8) id = 'lt'
      if (key === 46 || key === 13) id = 'C'
      if (id < 0) return
      document.querySelector(`#button-${id}`).click()
    },
    update (e) {
      let amount = parseFloat(this.amount)
      let m = e.target.innerHTML

      if (m === '&lt;') {
        amount = (Math.floor(100 * (parseFloat(amount) / 10)) / 100)
      } else if (amount < 10000000) {
        if (m === '00') {
          amount = 100 * amount
        } else {
          amount = 10 * amount + parseFloat(m) / 100
        }
      }

      if (m === 'C') {
        amount = 0
      }

      amount = amount.toFixed(2)
      this.$emit('update', amount)
    }
  },
  created: function () {
    document.addEventListener('keyup', this.keyup)
  },
  destroyed: function () {
    document.removeEventListener('keyup', this.keyup)
  }
}
</script>


<style lang="stylus">
  div.btn__content {
    width: 10px;
    padding: 0;
  }

  .numpad .btn {
    min-width: 75px;
  }
</style>

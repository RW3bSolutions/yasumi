<template>
  <div class="text-center q-pa-md" v-if="preload">
    <q-spinner
      color="green"
      size="3em"
      :thickness="10"
    />
    <div class="q-pt-sm">
      Please wait...
    </div>
  </div>
  <div v-else class="q-pa-md">
    <div class="row">
      <div class="col-12 col-md-4 q-pa-sm">
        <q-markup-table separator="cell" dense>
          <thead>
            <tr>
              <th width="33.33%">PARTICULARS</th>
              <th width="33.33%" class="text-center">ACCOUNT</th>
              <th width="33.33%" class="text-center">AMOUNT</th>
            </tr>
          </thead>
          <tbody>
            <tr class="bg-grey-2">
              <td colspan="3" class="text-center">REVENUES</td>
            </tr>
            <tr>
              <td class="text-weight-bold">SALES</td>
              <td class="text-center text-weight-bold">{{ numberFormat(total_sales) }}</td>
              <td></td>
            </tr>
            <tr class="bg-grey-2">
              <td colspan="3" class="text-center">EXPENSES</td>
            </tr>
            <tr v-for="(expense, index) in expenses" :key="index">
              <td>{{ expense.name }}</td>
              <td class="text-center"></td>
              <td class="text-center">{{ numberFormat(expense.total_expenses ?? 0) }}</td>
            </tr>

            <tr>
              <td class="text-weight-bold">TOTAL EXPENSES</td>
              <td></td>
              <td class="text-center text-weight-bold">{{ numberFormat(totalExp) }}</td>
            </tr>

            <tr class="bg-yellow">
              <td class="text-weight-bold">NET INCOME</td>
              <td class="text-center text-weight-bold">{{ numberFormat(total_sales - totalExp) }}</td>
              <td></td>
            </tr>
          </tbody>
        </q-markup-table>
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import numeral from 'numeral'

export default defineComponent({
  name: 'IndexPage',

  data () {
    return {
      preload: false,
      expenses: [],
      total_sales: 0
    }
  },

  created () {
    this.index()
  },

  methods: {
    numberFormat (param) {
      return numeral(param).format('0,0.00')
    },

    index () {
      this.$api.get('branch/expenses?dashboard=1', {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.expenses = response.data
          this.preload = false
        })

      this.$api.get('branch/sales?dashboard=1', {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.total_sales = response.data
        })
    }
  },

  computed: {
    totalExp () {
      let total = 0
      this.expenses.forEach(v => {
        if (v.total_expenses) {
          total += v.total_expenses
        }
      })
      return total
    }
  }
})
</script>

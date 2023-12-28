<template>
  <div class="row q-px-md q-pt-xs">
    <div class="col-8 col-md-6 q-py-sm q-pr-sm self-center">
      <q-breadcrumbs gutter="sm">
        <q-breadcrumbs-el label="Expenses" class="text-weight-medium" />
      </q-breadcrumbs>
    </div>
    <div class="col-8 col-md-4 q-py-sm q-px-sm self-center">
      <q-input color="dark" borderless dense debounce="300" v-model="filter" placeholder="Search" filled>
        <template v-slot:append>
          <q-icon name="search" />
        </template>
      </q-input>
    </div>
    <div class="col-4 col-md-2 q-py-sm q-px-sm self-center text-right">
      <q-btn icon="sort" class="full-width" color="dark" size="md" @click="filtering.modal = true" />
    </div>
  </div>

  <div>
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
    <div class="row q-px-sm" v-else>
      <div class="col-12 col-md-12 col-lg-9 q-pa-sm">
        <q-table
          square
          :dense="true"
          :rows="filterDataRange"
          :columns="columns"
          row-key="index"
          :filter="filter"
          v-model:pagination="pagination"
          :rows-per-page-options="[0]"
          separator="cell"
        >
          <template v-slot:body-cell-no="props">
            <q-td :props="props">
              <div>{{ props.rowIndex + 1 }}</div>
            </q-td>
          </template>
          <template v-slot:body-cell-petty_cash="props">
            <q-td :props="props">
              <q-icon name="check" v-if="props.value" />
              <q-icon name="close" v-else />
            </q-td>
          </template>
          <template v-slot:body-cell-cancelled="props">
            <q-td :props="props">
              <q-icon name="check" v-if="props.value" />
              <q-icon name="close" v-else />
            </q-td>
          </template>
        </q-table>
      </div>
      <div class="col-12 col-md-12 col-lg-3 q-pa-sm" v-if="!expense_category.preload">
        <q-markup-table dense separator="cell">
          <thead>
            <tr>
              <th width="50%">ACCOUNTS</th>
              <th width="50%" class="text-right">AMOUNT</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(e_row, index) in expense_category.rows" :key="index">
              <td style="white-space: inherit;">{{ e_row.name }}</td>
              <td class="text-right">{{ numberFormat(computePerExpenseCategory(e_row.name)) }}</td>
            </tr>
            <tr class="bg-yellow">
              <td class="text-right"><b>TOTAL</b></td>
              <td class="text-right"><b>{{ numberFormat(totalExpenses) }}</b></td>
            </tr>
          </tbody>
        </q-markup-table>
      </div>
    </div>

  </div>

  <q-dialog v-model="filtering.modal">
    <q-card style="width: 700px; max-width: 80vw;">
      <q-card-section>
        <div class="q-mb-sm">
          <q-input color="dark" type="date" label="Date From" square="" v-model="filtering.date_from" :dense="true" />
        </div>
        <div class="q-mb-sm">
          <q-input color="dark" type="date" label="Date To" square="" v-model="filtering.date_to" :dense="true" />
        </div>
        <div>
          <q-toggle
            size="sm"
            class="text-caption text-weight-medium"
            color="red"
            label="Cancelled"
            v-model="filtering.cancelled"
            :true-value="1"
            :false-value="0"
          />
        </div>
      </q-card-section>
      <q-separator/>
      <q-card-section class="text-right">
        <q-btn label="Reset" color="red" v-if="filtering.filtered" @click="filtering.filtered = 0, filtering.date_from = null, filtering.date_to = null, filtering.modal = false" />
        <q-btn label="Filter" color="green" v-else @click="filtering.filtered = 1, filtering.modal = false" :disable="!filtering.date_from || !filtering.date_to" />
      </q-card-section>
    </q-card>
  </q-dialog>
</template>

<script>
import { defineComponent } from 'vue'
import { date } from 'quasar'
import numeral from 'numeral'

export default defineComponent({
  name: 'ExpensesPage',
  components: {
  },
  data () {
    return {
      preload: true,
      role: localStorage.getItem('role'),
      rows: [],
      columns: [
        {
          name: 'date',
          label: 'DATE',
          field: row => row.date,
          format: v => date.formatDate(v, 'MMM DD, YYYY'),
          align: 'left',
          sortable: true
        },
        {
          name: 'particulars',
          label: 'PARTICULARS',
          field: row => row.particulars,
          align: 'left',
          sortable: true
        },
        {
          name: 'payee',
          label: 'PAYEE',
          field: row => row.payee,
          align: 'left',
          sortable: true
        },
        {
          name: 'amount',
          label: 'AMOUNT',
          field: row => row.amount,
          align: 'left',
          sortable: true
        },
        {
          name: 'expense_category',
          label: 'EXPENSE CATEGORY',
          field: row => row.expense_category,
          align: 'left',
          sortable: true
        },
        {
          name: 'petty_cash',
          label: 'PETTY CASH',
          field: row => row.petty_cash,
          align: 'center',
          style: 'width: 5%'
        },
        {
          name: 'cancelled',
          label: 'CANCELLED',
          field: row => row.cancelled,
          align: 'center',
          style: 'width: 5%'
        }
      ],
      filter: null,
      pagination: {
        rowsPerPage: 15
      },
      modal: false,
      expense_category: {
        preload: true,
        rows: []
      },

      filtering: {
        modal: false,
        filtered: 0,
        date_from: null,
        date_to: null,
        cancelled: 0,
        expense_category: null
      }
    }
  },

  mounted () {
    this.index()
  },

  methods: {
    numberFormat (param) {
      return numeral(param).format('0,0.00')
    },

    computePerExpenseCategory (param) {
      let total = 0
      this.filterDataRange.forEach(v => {
        if (param === v.expense_category) {
          total += v.amount
        }
      })
      return total
    },

    index () {
      this.$api.get('admin/expenses?branch_id=' + this.$route.params.id, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.rows = response.data
          this.preload = false
        })

      this.$api.get('admin/expenses/create', {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.expense_category.rows = response.data
          this.expense_category.preload = false
        })
    },
    create () {
      this.modal = true
      this.ifEdit = false
      this.errors.show = false
      this.submitted = false
      this.form.date = date.formatDate(Date.now(), 'YYYY-MM-DD')
      this.form.particulars = null
      this.form.payee = null
      this.form.amount = null
      this.form.expense_category = null
      this.form.petty_cash = 0
      this.form.cancelled = 0
      this.form.check_cancel = 0
    },
    store () {
      this.submitted = true
      this.errors.show = false
      this.$api.post('admin/expenses', {
        petty_cash: this.form.petty_cash,
        date: this.form.date,
        particulars: this.form.particulars,
        payee: this.form.payee,
        amount: this.form.amount,
        expense_category: this.form.expense_category,
        cancelled: 0
      }, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.rows.push(response.data)
          this.submitted = false
          this.modal = false
          this.$q.notify({
            progress: true,
            type: 'positive',
            message: 'Success',
            icon: 'check'
          })
        })
        .catch(error => {
          if (error.response.status === 422) {
            this.errors.form = error.response.data.errors
            this.errors.show = true
          }
          this.submitted = false
        })
    },
    edit (param) {
      this.modal = true
      this.ifEdit = true
      this.errors.show = false
      this.submitted = false
      this.object = param
      this.form.petty_cash = param.petty_cash
      this.form.date = date.formatDate(param.date, 'YYYY-MM-DD')
      this.form.particulars = param.particulars
      this.form.payee = param.payee
      this.form.amount = param.amount
      this.form.expense_category = param.expense_category
      this.form.cancelled = param.cancelled
      this.form.check_cancel = param.cancelled
    },
    update () {
      this.submitted = true
      this.errors.show = false
      this.$api.post('admin/expenses/' + this.object.id, {
        petty_cash: this.form.petty_cash,
        date: this.form.date,
        particulars: this.form.particulars,
        payee: this.form.payee,
        amount: this.form.amount,
        expense_category: this.form.expense_category,
        cancelled: this.form.cancelled,
        _method: 'PUT'
      }, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.object.petty_cash = this.form.petty_cash
          this.object.date = this.form.date
          this.object.particulars = this.form.particulars
          this.object.payee = this.form.payee
          this.object.amount = this.form.amount
          this.object.expense_category = this.form.expense_category
          this.object.cancelled = this.form.cancelled
          this.modal = false
          this.$q.notify({
            progress: true,
            type: 'positive',
            message: 'Success',
            icon: 'check'
          })
        })
        .catch(error => {
          if (error.response.status === 422) {
            this.errors.form = error.response.data.errors
            this.errors.show = true
          }
          this.submitted = false
        })
    },
    destroy (param) {
      this.preload = true
      this.$api.post('admin/expenses/' + param, {
        _method: 'DELETE'
      }, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.index()
          this.$q.notify({
            progress: true,
            type: 'positive',
            message: 'Success',
            icon: 'check'
          })
        })
        .catch(error => {
          if (error.response.status === 422) {
            this.errors.form = error.response.data.errors
            this.errors.show = true
          }
          this.preload = false
        })
    }
  },

  computed: {
    filterDataRange () {
      if (this.filtering.filtered && this.filtering.date_from && this.filtering.date_to) {
        const from = this.filtering.date_from
        const to = this.filtering.date_to
        return this.rows.filter(v => v.date >= date.formatDate(from, 'YYYY-MM-DD') && v.date <= date.formatDate(to, 'YYYY-MM-DD') && v.cancelled === this.filtering.cancelled)
      }
      return this.rows
    },
    totalExpenses () {
      let total = 0
      this.filterDataRange.forEach(v => {
        total += v.amount
      })
      return total
    }
  }
})
</script>

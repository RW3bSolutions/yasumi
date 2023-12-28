<template>
  <div class="row q-px-md q-pt-xs">
    <div class="col-8 col-md-6 q-py-sm q-pr-sm self-center">
      <q-breadcrumbs gutter="sm">
        <q-breadcrumbs-el label="Refunds" class="text-weight-medium" />
      </q-breadcrumbs>
    </div>
    <div class="col-8 col-md-4 q-py-sm q-px-sm self-center">
      <q-input color="dark" borderless dense debounce="300" v-model="filter" placeholder="Search" filled>
        <template v-slot:append>
          <q-icon name="search" />
        </template>
      </q-input>
    </div>
    <div class="col-4 col-md-1 q-py-sm q-px-sm self-center text-right">
      <q-btn icon="sort" class="full-width" color="dark" size="md" @click="filtering.modal = true" />
    </div>
    <div class="col-4 col-md-1 q-py-sm q-px-sm self-center text-right">
      <q-btn icon="add" class="full-width" color="green" size="md" @click="create()" />
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
      <div class="col-12 col-md-12 col-lg-12 q-pa-sm">
        <q-table
          square
          :dense="true"
          :rows="rows"
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
          <template v-slot:body-cell-cancelled="props">
            <q-td :props="props">
              <q-icon name="check" v-if="props.value" />
              <q-icon name="close" v-else />
            </q-td>
          </template>
          <template v-slot:body-cell-action="props">
            <q-td :props="props">
              <q-btn-dropdown color="dark" label="Action" size="sm">
                <q-list class="q-pa-xs">
                  <q-item clickable v-close-popup @click="edit(props.value)" class="q-pa-xs">
                    <q-item-section class="bg-primary text-center text-white">
                      EDIT
                    </q-item-section>
                  </q-item>
                  <q-item clickable v-close-popup @click="viewLogs(props.value)" class="q-pa-xs" v-if="role === 'Owner'">
                    <q-item-section class="bg-dark text-center text-white">
                      LOGS
                    </q-item-section>
                  </q-item>
                  <!-- <q-item clickable v-close-popup @click="destroy(props.value)" class="q-pa-xs">
                    <q-item-section class="bg-red text-center text-white">
                      DELETE
                    </q-item-section>
                  </q-item> -->
                </q-list>
              </q-btn-dropdown>
            </q-td>
          </template>
        </q-table>
      </div>
    </div>

  </div>

  <q-dialog v-model="modal">
    <q-card style="width: 700px; max-width: 80vw;">
      <form @submit.prevent="ifEdit ? update() : store()">
        <q-card-section>
          <div class="text-h6">{{ ifEdit ? 'UPDATE REFUND' : 'NEW REFUND' }}</div>
          <div class="text-caption text-red">
            Required *
          </div>
        </q-card-section>
        <q-separator/>
        <q-card-section>
          <div class="q-mb-sm">
            <q-input color="dark" type="date" label="Date" square="" v-model="form.date" :dense="true">
              <template v-slot:after v-if="ifEdit">
                <q-toggle
                  size="sm"
                  class="text-caption text-weight-medium"
                  color="red"
                  label="Cancelled"
                  v-model="form.cancelled"
                  :true-value="1"
                  :false-value="0"
                />
              </template>
            </q-input>
            <div class="text-caption text-red" v-if="errors.form.date && errors.show">
              {{ errors.form.date[0] }}
            </div>
          </div>
          <div class="q-mb-sm">
            <q-input color="dark" label="Customer Name *" square="" :model-value="customer.object ? customer.object.name : null" :dense="true" readonly>
              <template v-slot:after>
                <q-btn icon="search" round color="primary" @click="customer.object = null, customer.rows = [], customer.modal = true" />
              </template>
            </q-input>
            <div class="text-caption text-red" v-if="errors.form.customer && errors.show">
              {{ errors.form.customer[0] }}
            </div>
          </div>
          <div class="q-mb-sm">
            <q-input color="dark" label="Service *" square="" v-model="form.service" :dense="true" autofocus="">
            </q-input>
            <div class="text-caption text-red" v-if="errors.form.service && errors.show">
              {{ errors.form.service[0] }}
            </div>
          </div>
          <div class="q-mb-sm">
            <q-input color="dark" label="Pax *" square="" v-model="form.pax" :dense="true" mask="###" />
            <div class="text-caption text-red" v-if="errors.form.pax && errors.show">
              {{ errors.form.pax[0] }}
            </div>
          </div>
          <div class="q-mb-sm">
            <q-input color="dark" label="Amount *" square="" v-model="form.amount" :dense="true" />
            <div class="text-caption text-red" v-if="errors.form.amount && errors.show">
              {{ errors.form.amount[0] }}
            </div>
          </div>
          <div class="q-mb-sm">
            <q-select color="dark" label="Payment Method *" square="" v-model="form.payment_method" :dense="true" :options="['Cash', 'Gcash']" >
            </q-select>
            <div class="text-caption text-red" v-if="errors.form.payment_method && errors.show">
              {{ errors.form.payment_method[0] }}
            </div>
          </div>
          <div class="q-mb-sm">
            <q-input color="dark" label="Amount Refund *" square="" v-model="form.amount_refund" :dense="true" />
            <div class="text-caption text-red" v-if="errors.form.amount_refund && errors.show">
              {{ errors.form.amount_refund[0] }}
            </div>
          </div>
          <div class="q-mb-sm">
            <q-input color="dark" label="Reason *" square="" v-model="form.reason" :dense="true" />
            <div class="text-caption text-red" v-if="errors.form.reason && errors.show">
              {{ errors.form.reason[0] }}
            </div>
          </div>
        </q-card-section>
        <template v-if="form.check_cancel == 0">
          <q-separator/>
            <q-card-section class="bg-white text-teal" v-if="!submitted">
              <q-btn type="submit" class="full-width" :color="ifEdit ? 'blue' : 'green'" :label="ifEdit ? 'Update' : 'Save'"/>
            </q-card-section>
            <q-card-section class="text-center" v-if="submitted">
              <q-spinner
                color="primary"
                size="md"
                :thickness="10"
              />
            </q-card-section>
            <q-separator/>
        </template>
      </form>
    </q-card>
  </q-dialog>

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

  <q-dialog v-model="activity_log.modal" full-width>
    <ActivityLogs v-bind:rows="activity_log.rows" />
  </q-dialog>

  <q-dialog v-model="customer.modal">
    <q-card style="width: 700px; max-width: 80vw;">
      <q-card-section>
        <q-input v-model="customer.search" label="Search Customer" dense color="dark" autofocus="" filled @keyup.enter="searchCustomer(customer.search)">
        <template v-slot:after>
            <q-btn icon="search" round color="primary" @click="searchCustomer(customer.search)" />
          </template>
        </q-input>
      </q-card-section>
      <q-separator v-if="customer.rows.length" />
      <q-markup-table v-if="customer.rows.length" separator="cell" dense>
        <thead>
          <tr>
            <th class="text-left">Customer Name</th>
            <th class="text-left">Contact No.</th>
            <th width="10%" class="text-center">Action</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(c_row, c_index) in customer.rows" :key="c_index">
            <td class="text-left">{{ c_row.name }}</td>
            <td class="text-left">{{ c_row.contact_no }}</td>
            <td class="text-center">
              <span class="text-weight-medium text-primary text-center cursor-pointer" @click="customer.object = c_row, customer.modal = false">SELECT</span>
            </td>
          </tr>
        </tbody>
      </q-markup-table>
    </q-card>
  </q-dialog>

</template>

<script>
import { defineComponent } from 'vue'
import { date } from 'quasar'
import ActivityLogs from 'components/ActivityLogs.vue'
import numeral from 'numeral'

export default defineComponent({
  name: 'ExpensesPage',
  components: {
    ActivityLogs
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
          name: 'customer',
          label: 'NAME',
          field: row => row.customer.name,
          align: 'left',
          sortable: true
        },
        {
          name: 'customer',
          label: 'CONTACT NO.',
          field: row => row.customer.contact_no,
          align: 'left',
          sortable: true
        },
        {
          name: 'service',
          label: 'SERVICE',
          field: row => row.service,
          align: 'left',
          sortable: true
        },
        {
          name: 'pax',
          label: 'PAX',
          field: row => row.pax,
          align: 'left',
          sortable: true
        },
        {
          name: 'amount',
          label: 'AMOUNT',
          field: row => row.amount,
          format: v => this.numberFormat(v),
          align: 'left',
          sortable: true
        },
        {
          name: 'payment_method',
          label: 'PAYMENT METHOD',
          field: row => row.payment_method,
          align: 'left',
          sortable: true
        },
        {
          name: 'amount_refund',
          label: 'AMOUNT REFUND',
          field: row => row.amount_refund,
          format: v => this.numberFormat(v),
          align: 'left',
          sortable: true
        },
        {
          name: 'reason',
          label: 'REASON',
          field: row => row.reason,
          align: 'left',
          sortable: true
        },
        {
          name: 'cancelled',
          label: 'CANCELLED',
          field: row => row.cancelled,
          align: 'center',
          style: 'width: 5%'
        },
        {
          name: 'action',
          label: '-',
          field: row => row,
          align: 'center',
          style: 'width: 5%'
        }
      ],
      filter: null,
      pagination: {
        rowsPerPage: 15
      },
      modal: false,
      object: false,
      ifEdit: false,
      ifView: false,
      form: {
        date: null,
        service: null,
        pax: null,
        amount: null,
        payment_method: null,
        amount_refund: null,
        cancelled: 0
      },
      errors: {
        show: false,
        form: {
          date: null,
          customer: null,
          service: null,
          pax: null,
          amount: null,
          payment_method: null,
          amount_refund: null,
          cancelled: 0,
          check_cancel: 0
        }
      },
      submitted: false,
      activity_log: {
        modal: false,
        rows: []
      },
      filtering: {
        modal: false,
        filtered: 0,
        date_from: null,
        date_to: null,
        cancelled: 0,
        expense_category: null
      },
      customer: {
        search: null,
        object: null,
        preload: true,
        rows: [],
        modal: false
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

    viewLogs (param) {
      this.$api.post('global/activity-logs', {
        log_name: 'Refund',
        subject_id: param.id
      }, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          console.log(response.data)
          this.activity_log.rows = response.data
          this.activity_log.modal = true
        })
    },

    index () {
      this.$api.get('branch/refunds', {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.rows = response.data
          this.preload = false
        })
    },
    create () {
      this.modal = true
      this.ifEdit = false
      this.errors.show = false
      this.submitted = false
      this.customer.object = null
      this.form.date = date.formatDate(Date.now(), 'YYYY-MM-DD')
      this.form.service = null
      this.form.pax = null
      this.form.amount = null
      this.form.payment_method = null
      this.form.amount_refund = null
      this.form.reason = null
      this.form.cancelled = 0
      this.form.check_cancel = 0
    },

    searchCustomer (param) {
      this.customer.rows = []
      this.$api.get('branch/customers/' + param, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.customer.rows = response.data
          this.customer.preload = false
        })
    },

    store () {
      this.submitted = true
      this.errors.show = false
      this.$api.post('branch/refunds', {
        customer: this.customer.object ? this.customer.object.id : null,
        date: this.form.date,
        service: this.form.service,
        pax: this.form.pax,
        amount: this.form.amount,
        payment_method: this.form.payment_method,
        amount_refund: this.form.amount_refund,
        reason: this.form.reason,
        cancelled: 0
      }, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.submitted = false
          this.modal = false
          this.$q.notify({
            progress: true,
            type: 'positive',
            message: 'Success',
            icon: 'check'
          })
          this.index()
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
      this.form.service = param.service
      this.form.pax = param.pax
      this.form.amount = param.amount
      this.form.payment_method = param.payment_method
      this.form.amount_refund = param.amount_refund
      this.form.reason = param.reason
      this.form.cancelled = param.cancelled
      this.form.check_cancel = param.cancelled
      this.customer.object = {
        id: param.customer.id,
        name: param.customer.name
      }
    },
    update () {
      this.submitted = true
      this.errors.show = false
      this.$api.post('branch/refunds/' + this.object.id, {
        customer: this.customer.object ? this.customer.object.id : null,
        date: this.form.date,
        service: this.form.service,
        pax: this.form.pax,
        amount: this.form.amount,
        payment_method: this.form.payment_method,
        amount_refund: this.form.amount_refund,
        reason: this.form.reason,
        cancelled: this.form.cancelled,
        _method: 'PUT'
      }, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.index()
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
      this.$api.post('branch/refunds/' + param, {
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

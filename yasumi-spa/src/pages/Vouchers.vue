<template>
  <div class="row q-px-md q-py-xs" v-if="role === 'Owner'">
    <div class="col-12 col-md-6 q-py-sm self-center">
      <q-breadcrumbs gutter="sm">
        <q-breadcrumbs-el label="Vouchers" class="text-weight-medium" />
      </q-breadcrumbs>
    </div>
    <div class="col-8 col-md-4 q-py-sm q-pr-sm self-center">
      <q-input color="dark" borderless dense debounce="300" v-model="filter" placeholder="Search" filled>
        <template v-slot:append>
          <q-icon name="search" />
        </template>
      </q-input>
    </div>
    <div class="col-4 col-md-2 q-py-sm self-center text-right">
      <q-btn icon="add" label="New" class="full-width" color="green" size="md" @click="create()" v-if="role === 'Owner'" />
      <!-- <q-btn icon="refresh" round color="black" size="md" @click="preload = true, index()" /> -->
    </div>
  </div>

  <div class="q-pb-sm q-px-md" v-if="role === 'Owner'">
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
    <q-table
      v-else
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
      <template v-slot:body-cell-add_on="props">
        <q-td :props="props">
          <q-icon name="check" v-if="props.value" />
          <span v-else>-</span>
        </q-td>
      </template>
      <template v-slot:body-cell-action="props">
        <q-td :props="props">
          <q-btn-dropdown color="dark" label="Action" size="sm">
            <q-list class="q-pa-xs">
              <q-item clickable v-close-popup @click="edit(props.value)" class="q-pa-xs" v-if="role === 'Owner'">
                <q-item-section class="bg-primary text-center text-white">
                  EDIT
                </q-item-section>
              </q-item>
              <q-item clickable v-close-popup @click="viewLogs(props.value)" class="q-pa-xs" v-if="role === 'Owner'">
                <q-item-section class="bg-dark text-center text-white">
                  LOGS
                </q-item-section>
              </q-item>
            </q-list>
          </q-btn-dropdown>
        </q-td>
      </template>
    </q-table>
  </div>

  <q-dialog v-model="modal" v-if="role === 'Owner'">
    <q-card style="width: 700px; max-width: 80vw;">
      <form @submit.prevent="ifEdit ? update() : store()">
        <q-card-section>
          <div class="text-h6">{{ ifEdit ? 'UPDATE VOUCHER' : 'NEW VOUCHER' }}</div>
          <div class="text-caption text-red">
            Required *
          </div>
        </q-card-section>
        <q-separator/>
        <q-card-section>
          <div class="">
            <q-input color="dark" label="Amount *" square="" v-model="form.amount" :dense="true" autofocus="" />
            <div class="text-caption text-red" v-if="errors.form.amount && errors.show">
              {{ errors.form.amount[0] }}
            </div>
          </div>
        </q-card-section>
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
      </form>
    </q-card>
  </q-dialog>
  <q-dialog v-model="activity_log.modal" full-width>
    <ActivityLogs v-bind:rows="activity_log.rows" />
  </q-dialog>

  <q-dialog v-model="commission.modal" full-width>
    <q-card>
      <q-card-section>
        <Commissions v-bind:id="commission.id" />
      </q-card-section>
    </q-card>
  </q-dialog>
</template>

<script>
import { defineComponent } from 'vue'
import ActivityLogs from 'components/ActivityLogs.vue'
import Commissions from 'components/Commissions.vue'
import { date } from 'quasar'
import numeral from 'numeral'

export default defineComponent({
  name: 'TherapistsPage',
  components: {
    ActivityLogs,
    Commissions
  },
  data () {
    return {
      preload: true,
      role: localStorage.getItem('role'),
      rows: [],
      columns: [
        {
          name: 'created_at',
          label: 'CREATED AT',
          field: row => row.created_at,
          format: v => date.formatDate(v, 'MMM DD, YYYY'),
          align: 'left',
          sortable: true
        },
        {
          name: 'code',
          label: 'CODE',
          field: row => row.code,
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
          name: 'customer',
          label: 'CUSTOMER',
          field: row => row.booking ? row.booking.customer.name : '-',
          align: 'left',
          sortable: true
        },
        {
          name: 'booking.date',
          label: 'BOOKING DATE',
          field: row => row.booking ? date.formatDate(row.booking.date, 'MMM DD, YYYY') : '-',
          align: 'left',
          sortable: true
        },
        {
          name: 'booking',
          label: 'REDEEMED',
          field: row => row.booking ? 'Used' : 'Available',
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
        amount: null
      },
      errors: {
        show: false,
        form: {
          amount: null
        }
      },
      submitted: false,
      activity_log: {
        modal: false,
        rows: []
      },
      commission: {
        id: null,
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
        log_name: 'Voucher',
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
      this.$api.get('branch/vouchers', {
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
      this.form.amount = null
    },
    store () {
      this.submitted = true
      this.errors.show = false
      this.$api.post('branch/vouchers', {
        amount: this.form.amount
      }, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.index()
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
      this.form.amount = param.amount
    },
    update () {
      this.submitted = true
      this.errors.show = false
      this.$api.post('branch/vouchers/' + this.object.id, {
        amount: this.form.amount,
        _method: 'PUT'
      }, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.object.amount = this.form.amount
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
      this.$api.post('branch/vouchers/' + param, {
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
  }
})
</script>

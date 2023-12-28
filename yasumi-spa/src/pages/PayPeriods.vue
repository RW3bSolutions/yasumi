<template>
  <div class="row q-px-md q-py-xs" v-if="role === 'Owner'">
    <div class="col-12 col-md-6 q-py-sm self-center">
      <q-breadcrumbs gutter="sm">
        <q-breadcrumbs-el label="Payroll" class="text-weight-medium" />
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
      <q-btn icon="add" label="New" class="full-width" color="green" size="md" @click="create()" />
      <!-- <q-btn icon="refresh" round color="black" size="md" @click="preload = true, index()" /> -->
    </div>
  </div>

  <div class="q-pb-sm q-px-md" v-if="role === 'Owner'">
    <div class="text-center q-pa-md" v-if="preload || employee.preload">
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
              <!-- <q-item clickable v-close-popup @click="edit(props.value)" class="q-pa-xs">
                <q-item-section class="bg-primary text-center text-white">
                  EDIT
                </q-item-section>
              </q-item> -->
              <q-item clickable v-close-popup class="q-pa-xs" @click="show(props.value.id)" v-if="role === 'Owner'">
                <q-item-section class="bg-green text-center text-white">
                  PAYROLL
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

  <q-dialog v-model="modal">
    <q-card style="width: 700px; max-width: 80vw;">
      <form @submit.prevent="ifEdit ? update() : store()">
        <q-card-section>
          <div class="text-h6">{{ ifEdit ? 'UPDATE PAY PERIOD' : 'NEW PAY PERIOD' }}</div>
          <div class="text-caption text-red">
            Required *
          </div>
        </q-card-section>
        <q-separator/>
        <q-card-section>
          <div class="q-mb-sm">
            <q-input type="date" color="dark" label="Date From *" square="" v-model="form.date_from" :dense="true"></q-input>
            <div class="text-caption text-red" v-if="errors.form.date_from && errors.show">
              {{ errors.form.date_from[0] }}
            </div>
          </div>
          <div>
            <q-input type="date" color="dark" label="Date From *" square="" v-model="form.date_to" :dense="true"></q-input>
            <div class="text-caption text-red" v-if="errors.form.date_to && errors.show">
              {{ errors.form.date_to[0] }}
            </div>
          </div>
        </q-card-section>
        <q-separator/>
        <q-card-section>
          <q-markup-table>
            <thead>
              <tr>
                <th width="50%">EMPLOYEE NAME</th>
                <th width="50%">ABSENT</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(emp, index) in employee.rows" :key="index">
                <td>{{ emp.name }}</td>
                <td>
                  <q-input dense="" filled label="Absent" v-model="emp.absent" />
                </td>
              </tr>
            </tbody>
          </q-markup-table>
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

  <q-dialog v-model="payroll.modal" full-width>
    <q-card>
      <q-card-section>
        <q-markup-table dense separator="cell" class="text-left">
            <thead>
              <tr>
                <th>EMPLOYEE NAME</th>
                <th>ABSENT</th>
                <th>NET PAY</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(pay, pIndex) in payroll.rows" :key="pIndex">
                <td>
                  <span v-if="pay.employee">
                    {{ pay.employee.name }}
                  </span>
                  <span v-if="pay.therapist">
                    {{ pay.therapist.name }}
                  </span>
                </td>
                <td>{{ numberFormat(pay.absent) }}</td>
                <td>{{ numberFormat(pay.net_pay) }}</td>
              </tr>
            </tbody>
          </q-markup-table>
      </q-card-section>
    </q-card>
  </q-dialog>

</template>

<script>
import { defineComponent } from 'vue'
import ActivityLogs from 'components/ActivityLogs.vue'
import numeral from 'numeral'
import { date } from 'quasar'

export default defineComponent({
  name: 'RoomsPage',
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
          name: 'date_from',
          label: 'DATE FROM',
          field: row => row.date_from,
          format: v => date.formatDate(v, 'MMM DD, YYYY'),
          align: 'left',
          sortable: true
        },
        {
          name: 'date_to',
          label: 'DATE TO',
          field: row => row.date_to,
          format: v => date.formatDate(v, 'MMM DD, YYYY'),
          align: 'left',
          sortable: true
        },
        {
          name: 'total_payouts',
          label: 'TOTAL PAYOUTS',
          field: row => row.total_payouts,
          format: v => this.numberFormat(v),
          align: 'left',
          sortable: true
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
        date_from: null,
        date_to: null
      },
      errors: {
        show: false,
        form: {
          date_from: null,
          date_to: null
        }
      },
      submitted: false,
      employee: {
        preload: true,
        rows: []
      },
      payroll: {
        modal: false,
        preload: true,
        rows: []
      },
      activity_log: {
        modal: false,
        rows: []
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
        log_name: 'PayPeriod',
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
      this.$api.get('branch/pay-periods', {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.rows = response.data
          this.preload = false
        })

      this.$api.get('branch/employees?active=1', {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.employee.rows = response.data
          this.employee.preload = false
        })
    },

    show (param) {
      this.$api.get('branch/pay-periods/' + param, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.payroll.rows = response.data
          this.payroll.preload = false
          this.payroll.modal = true
        })
    },

    create () {
      this.modal = true
      this.ifEdit = false
      this.errors.show = false
      this.submitted = false
      this.form.name = null
      this.form.commission = null
      this.form.is_active = 1
    },
    store () {
      this.submitted = true
      this.errors.show = false
      this.$api.post('branch/pay-periods', {
        date_from: this.form.date_from,
        date_to: this.form.date_to,
        employees: this.employee.rows
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
      this.form.name = param.name
      this.form.commission = param.commission
      this.form.is_active = param.is_active
    },
    update () {
      this.submitted = true
      this.errors.show = false
      this.$api.post('branch/pay-periods/' + this.object.id, {
        name: this.form.name,
        commission: this.form.commission,
        is_active: this.form.is_active,
        _method: 'PUT'
      }, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.object.name = this.form.name
          this.object.commission = this.form.commission
          this.object.is_active = this.form.is_active
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
      this.$api.post('branch/pay-periods/' + param, {
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

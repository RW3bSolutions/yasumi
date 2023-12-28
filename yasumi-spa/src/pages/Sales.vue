<template>
  <div class="row q-px-md q-py-xs">
    <div class="col-12 col-md-6 q-py-sm self-center text-weight-medium">
      TOTAL SALES: {{ numberFormat(totalSales) }}
    </div>
    <div class="col-8 col-md-4 q-py-sm q-pr-sm self-center">
      <q-input color="dark" borderless dense debounce="300" v-model="filter" placeholder="Search" filled>
        <template v-slot:append>
          <q-icon name="search" />
        </template>
      </q-input>
    </div>
    <div class="col-4 col-md-2 q-py-sm self-center text-right">
      <q-btn icon="sort" label="Filter" class="full-width" color="dark" size="md"  @click="filtering.modal = true" />
    </div>
  </div>

  <div class="q-pb-sm q-px-md">
    <div class="text-center q-pa-md" v-if="preload || therapist.preload">
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
      <template v-slot:body-cell-add_on="props">
        <q-td :props="props">
          <q-icon name="check" v-if="props.value" />
          <q-icon name="close" v-else />
        </q-td>
      </template>
      <template v-slot:body-cell-therapists="props">
        <q-td :props="props">
          <span v-if="props.value === 'null' || props.value === null || props.value === ''">-</span>
          <span v-else v-for="(val, index) in JSON.parse(props.value)" :key="index">
            <span v-if="index >= 1"> /</span> {{ findTherapist(val) }}
          </span>
        </q-td>
      </template>
      <template v-slot:body-cell-action="props">
        <q-td :props="props">
          <q-btn-dropdown color="dark" label="Action" size="sm" v-if="role === 'Owner'">
            <q-list class="q-pa-xs">
              <q-item clickable v-close-popup @click="viewLogs(props.value)" class="q-pa-xs">
                <q-item-section class="bg-dark text-center text-white">
                  LOGS
                </q-item-section>
              </q-item>
            </q-list>
          </q-btn-dropdown>
          <span v-else>-</span>
        </q-td>
      </template>
    </q-table>
  </div>
  <q-dialog v-model="activity_log.modal" full-width>
    <ActivityLogs v-bind:rows="activity_log.rows" />
  </q-dialog>

  <q-dialog v-model="filtering.modal">
    <q-card style="width: 700px; max-width: 80vw;">
      <q-card-section>
        <div class="q-mb-sm">
          <q-input color="dark" type="date" label="Date From" square="" v-model="filtering.date_from" :dense="true" />
        </div>
        <div>
          <q-input color="dark" type="date" label="Date To" square="" v-model="filtering.date_to" :dense="true" />
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
import ActivityLogs from 'components/ActivityLogs.vue'
import numeral from 'numeral'
import { date } from 'quasar'

export default defineComponent({
  name: 'SalesPage',
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
          field: row => row.booking.date,
          format: v => date.formatDate(v, 'MMM DD, YYYY'),
          align: 'left',
          sortable: true
        },
        {
          name: 'name',
          label: 'CUSTOMER NAME',
          field: row => row.booking.customer.name,
          align: 'left',
          sortable: true
        },
        {
          name: 'contact_no',
          label: 'CONTACT NO.',
          field: row => row.booking.customer.contact_no,
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
          name: 'amount',
          label: 'AMOUNT',
          field: row => row.amount,
          format: v => this.numberFormat(v),
          align: 'left',
          sortable: true
        },
        {
          name: 'therapists',
          label: 'THERAPISTS',
          field: row => row.therapists,
          align: 'left',
          sortable: true
        },
        {
          name: 'add_on',
          label: 'ADD-ON',
          field: row => row.add_on,
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
      therapist: {
        modal: false,
        preload: true,
        rows: []
      },
      activity_log: {
        modal: false,
        rows: []
      },
      filtering: {
        modal: false,
        filtered: 0,
        date_from: null,
        date_to: null
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

    findTherapist (param) {
      const find = this.therapist.rows.find(v => v.id === param)
      return find.name
    },

    viewLogs (param) {
      this.$api.post('global/activity-logs', {
        log_name: 'Sales',
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
      this.$api.get('branch/therapists?active=1', {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.therapist.rows = response.data
          this.therapist.preload = false
        })

      this.$api.get('branch/sales', {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.rows = response.data
          this.preload = false
        })
    }
  },
  computed: {
    filterDataRange () {
      if (this.filtering.filtered && this.filtering.date_from && this.filtering.date_to) {
        const from = this.filtering.date_from
        const to = this.filtering.date_to
        return this.rows.filter(v => v.booking.date >= date.formatDate(from, 'YYYY-MM-DD') && v.booking.date <= date.formatDate(to, 'YYYY-MM-DD'))
      }
      return this.rows
    },
    totalSales () {
      let total = 0
      this.filterDataRange.forEach(v => {
        total += v.amount
      })
      return total
    }
  }
})
</script>

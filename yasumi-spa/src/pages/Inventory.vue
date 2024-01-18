<template>
  <div class="row q-px-md q-py-xs" v-if="role === 'Owner'">
    <div class="col-12 col-md-6 q-py-sm self-center">
      <q-breadcrumbs gutter="sm">
        <q-breadcrumbs-el label="Inventory" class="text-weight-medium" />
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
              <q-item clickable v-close-popup @click="btnStock(props.value.id, 'Stock-In')" class="q-pa-xs">
                <q-item-section class="bg-green text-center text-white">
                  STOCK-IN
                </q-item-section>
              </q-item>
              <q-item clickable v-close-popup @click="btnStock(props.value.id, 'Stock-Out')" class="q-pa-xs">
                <q-item-section class="bg-red text-center text-white">
                  STOCK-OUT
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
          <div class="text-h6">{{ ifEdit ? 'UPDATE ROOM' : 'NEW ROOM' }}</div>
          <div class="text-caption text-red">
            Required *
          </div>
        </q-card-section>
        <q-separator/>
        <q-card-section>
          <div>
            <q-input color="dark" label="Name *" square="" v-model="form.name" :dense="true" autofocus=""></q-input>
            <div class="text-caption text-red" v-if="errors.form.name && errors.show">
              {{ errors.form.name[0] }}
            </div>
          </div>
          <div class="q-mt-sm">
            <q-input color="dark" label="Unit *" square="" v-model="form.unit" :dense="true" autofocus=""></q-input>
            <div class="text-caption text-red" v-if="errors.form.unit && errors.show">
              {{ errors.form.unit[0] }}
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

  <q-dialog v-model="stock.dialog" full-width>

    <div class="bg-white text-center q-pa-md" v-if="stock.preload">
      <q-spinner
        color="green"
        size="3em"
        :thickness="10"
      />
      <div class="q-pt-sm">
        Please wait...
      </div>
    </div>
    <q-card class="row" v-else>
      <div class="col-12 col-md-4 q-pa-md">
        <q-card>
          <form @submit.prevent="updateStock()">
            <q-card-section>
              <div class="text-h6">{{ stock.form.event }}</div>
              <div class="text-caption text-red">
                Required *
              </div>
            </q-card-section>
            <q-separator/>
            <q-card-section>
              <div>
                <q-input color="dark" label="Description *" square="" v-model="stock.form.description" :dense="true" autofocus=""></q-input>
                <div class="text-caption text-red" v-if="stock.errors.form.description && stock.errors.show">
                  {{ stock.errors.form.description[0] }}
                </div>
              </div>
              <div class="q-mt-sm">
                <q-input color="dark" label="Qty *" square="" v-model="stock.form.qty" :dense="true" autofocus=""></q-input>
                <div class="text-caption text-red" v-if="stock.errors.form.qty && stock.errors.show">
                  {{ stock.errors.form.qty[0] }}
                </div>
              </div>
            </q-card-section>
            <q-separator/>
            <q-card-section class="bg-white text-teal">
              <q-btn type="submit" class="full-width" color="green" label="Submit" />
            </q-card-section>
            <q-separator/>
          </form>
        </q-card>
      </div>
      <div class="col-12 col-md-8 q-pa-md">
        <q-markup-table dense separator="cell">
          <thead>
            <tr class="bg-green text-white text-left">
              <th colspan="3">
                {{ findItem }}
              </th>
            </tr>
            <tr class="bg-grey-2">
              <th class="text-left">Description</th>
              <th class="text-left">Qty</th>
              <th width="10%" class="text-right">Date & Time</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(stck, index) in filterStocks" :key="index">
              <td class="text-left">{{ stck.description }}</td>
              <td class="text-left">{{ stck.qty }}</td>
              <td class="text-right">{{ dateAndTime(stck.created_at) }}</td>
            </tr>
            <tr>
              <td class="text-right">TOTAL</td>
              <td class="bg-yellow"><b>{{ totalStock }}</b></td>
              <td></td>
            </tr>
          </tbody>
        </q-markup-table>
      </div>
    </q-card>
  </q-dialog>

  <q-dialog v-model="activity_log.modal" full-width>
    <ActivityLogs v-bind:rows="activity_log.rows" />
  </q-dialog>
</template>

<script>
import { defineComponent } from 'vue'
import ActivityLogs from 'components/ActivityLogs.vue'
import { date } from 'quasar'
import numeral from 'numeral'

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
          name: 'name',
          label: 'PRODUCT NAME',
          field: row => row.name,
          align: 'left',
          sortable: true
        },
        {
          name: 'unit',
          label: 'UNIT',
          field: row => row.unit,
          align: 'left',
          sortable: true
        },
        {
          name: 'stock',
          label: 'STOCK',
          field: row => row.stock,
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
        name: null,
        unit: null,
        stock: 0
      },
      errors: {
        show: false,
        form: {
          name: null,
          unit: null,
          stock: 0
        }
      },
      submitted: false,
      activity_log: {
        modal: false,
        rows: []
      },
      stock: {
        dialog: false,
        preload: false,
        rows: [],
        form: {
          description: null,
          event: null,
          item_id: null,
          qty: null
        },
        errors: {
          show: false,
          form: {
            description: null,
            event: null,
            item_id: null,
            qty: null
          }
        }
      }
    }
  },

  mounted () {
    this.index()
  },

  methods: {
    dateAndTime (param) {
      return date.formatDate(param, 'MMM DD, YYYY - hh:mm a')
    },

    btnStock (param, paramA) {
      this.stock.form.event = paramA
      this.stock.preload = true
      this.$api.get('branch/item-stocks?item_id=' + param, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.stock.rows = response.data
          this.stock.form.item_id = param
          this.stock.preload = false
          this.stock.dialog = true
        })
    },

    updateStock () {
      this.stock.preload = true
      this.stock.errors.show = false
      this.$api.post('branch/item-stocks', {
        description: this.stock.form.description,
        qty: this.stock.form.qty,
        event: this.stock.form.event,
        item_id: this.stock.form.item_id
      }, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.index()
          this.stock.rows.push(response.data)
          this.$q.notify({
            progress: true,
            type: 'positive',
            message: 'Success',
            icon: 'check'
          })
          this.stock.form.description = null
          this.stock.form.qty = null
          this.stock.preload = false
        })
        .catch(error => {
          if (error.response.status === 422) {
            this.stock.errors.form = error.response.data.errors
            this.stock.errors.show = true
          }
          this.stock.preload = false
        })
    },

    numberFormat (param) {
      return numeral(param).format('0,0.00')
    },

    viewLogs (param) {
      this.$api.post('global/activity-logs', {
        log_name: 'Item',
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
      this.$api.get('branch/items', {
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
      this.form.name = null
      this.form.unit = null
    },
    store () {
      this.submitted = true
      this.errors.show = false
      this.$api.post('branch/items', {
        name: this.form.name,
        unit: this.form.unit,
        stock: 0
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
      this.form.name = param.name
      this.form.unit = param.unit
      this.form.stock = param.stock
    },
    update () {
      this.submitted = true
      this.errors.show = false
      this.$api.post('branch/items/' + this.object.id, {
        name: this.form.name,
        unit: this.form.unit,
        stock: this.form.stock,
        _method: 'PUT'
      }, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.object.name = this.form.name
          this.object.unit = this.form.unit
          this.object.stock = this.form.stock
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
      this.$api.post('branch/items/' + param, {
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
    filterStocks () {
      return this.stock.rows.filter(v => v.event === this.stock.form.event)
    },
    findItem () {
      return this.rows.find(v => v.id === this.stock.form.item_id).name
    },
    totalStock () {
      let total = 0
      this.filterStocks.forEach(v => {
        total += Number(v.qty)
      })
      return total
    }
  }
})
</script>

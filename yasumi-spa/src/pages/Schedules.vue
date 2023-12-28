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
      <div class="col-12 col-md-1 col-lg-1 q-pb-sm q-px-sm self-center">
        <q-btn icon="refresh" color="dark" class="full-width" @click="preload = true, index()" />
      </div>
      <div class="col-12 col-md-3 col-lg-2 q-pb-sm q-px-sm self-center">
        <q-btn icon="event" class="full-width" color="dark" :label="dateTimeFormat(date)" outline="">
          <q-popup-proxy cover transition-show="scale" transition-hide="scale">
            <q-date v-model="date">
              <div class="row items-center justify-end q-gutter-sm">
                <q-btn label="Cancel" color="primary" flat v-close-popup />
                <q-btn label="Submit" color="primary" flat @click="changeDate()" v-close-popup />
              </div>
            </q-date>
          </q-popup-proxy>
        </q-btn>
      </div>
      <div class="col-12 col-md-8 col-lg-9 q-pb-sm q-px-sm self-center">
        <span class="text-weight-medium text-primary q-px-sm">
          <q-icon name="edit_calendar" size="sm" /> Pending
        </span>
        <span class="text-weight-medium text-green q-px-sm">
          <q-icon name="check" size="sm" /> Completed
        </span>
        <span class="text-weight-medium text-red q-px-sm">
          <q-icon name="close" size="sm" /> Cancelled
        </span>
        <span class="text-weight-medium text-dark q-px-sm">
          <q-icon name="pending_actions" size="sm" /> Reschedule
        </span>
      </div>
    </div>
    <q-markup-table separator="cell">
      <thead>
        <tr class="bg-green text-white">
          <th v-for="(row, index) in rows" :key="index">
            {{ row.name }}
          </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td v-for="(row, index) in rows" :key="index">
            <q-btn outline="" label="Add Booking" color="dark" class="full-width" @click="addBooking(row), room = row.name" />
          </td>
        </tr>
        <tr v-if="booking.rows.length">
          <td v-for="(row, index) in rows" :key="index">
            <q-list style="width: 200px; max-width: 250px;">
              <q-item @click="booking.object = b, form.fp = b.total_amount - (b.dp + b.fp), booking.modal = true, resched.date = null" clickable v-for="(b, i) in filterByRoom(row.id)" :key="i" class="q-py-xs q-px-none">
                <q-tooltip class="bg-dark" :offset="[10, 10]">
                  <template v-for="(s, sIndex) in b.sales" :key="sIndex">
                    <span v-if="sIndex !== 0"> + </span> {{ s.service }}
                  </template>
                </q-tooltip>
                <q-item-section :class="b.status === 'Pending' ? 'bg-primary' : '' + b.status === 'Completed' ? 'bg-green' : '' + b.status === 'Cancelled' ? 'bg-red' : '' + b.status === 'Reschedule' ? 'bg-dark' : ''" class="q-pa-md">
                  <q-item-label class="text-weight-bold text-white">
                    {{ timeFormat(b.time) }}
                    <q-icon name="edit_calendar" color="white" class="float-right" size="xs" v-if="b.status === 'Pending'" />
                    <q-icon name="check" color="white" class="float-right" size="xs" v-if="b.status === 'Completed'" />
                    <q-icon name="close" color="white" class="float-right" size="xs" v-if="b.status === 'Cancelled'" />
                    <q-icon name="pending_actions" color="white" class="float-right" size="xs" v-if="b.status === 'Reschedule'" />
                  </q-item-label>
                  <q-item-label class="text-weight-medium text-white" lines="2" style="white-space: nowrap;">
                    <template v-for="(s, sIndex) in b.sales" :key="sIndex">
                      {{ s.service }}
                    </template>
                  </q-item-label>
                  <q-item-label class="text-weight-medium text-white">{{ b.customer.name }}</q-item-label>
                  <q-item-label class="text-weight-medium text-white">{{ b.customer.contact_no }}</q-item-label>
                  <q-item-label caption class="text-white text-weight-medium" v-if="b.dp">DP: {{ numberFormat(b.dp) }} <span v-if="b.fp">/ FP: {{ numberFormat(b.fp) }}</span></q-item-label>
                  <q-item-label caption class="text-white text-weight-medium" v-if="b.total_amount - (b.dp + b.fp) != 0">Balance: {{ numberFormat(b.total_amount - (b.dp + b.fp)) }}</q-item-label>
                </q-item-section>
              </q-item>
            </q-list>
          </td>
        </tr>
      </tbody>
    </q-markup-table>

    <q-dialog v-model="booking.modal">
      <q-card v-if="booking.object" style="width: 750px; max-width: 80vw;">
        <q-card-section class="text-weight-medium">
          {{ findRoom(booking.object.room_id) }}
          <span class="float-right">
            <q-icon name="edit_calendar" color="primary" size="xs" v-if="booking.object.status === 'Pending'" />
            <q-icon name="check" color="green" size="xs" v-if="booking.object.status === 'Completed'" />
            <q-icon name="close" color="red" size="xs" v-if="booking.object.status === 'Cancelled'" />
            <q-icon name="pending_actions" color="dark" size="xs" v-if="booking.object.status === 'Reschedule'" />
            {{ booking.object.status }}
          </span>
        </q-card-section>
        <q-separator/>
        <q-card-section class="q-pt-none">
          <q-item-section>
            <q-item-label class="text-weight-bold text-white">
              {{ timeFormat(booking.object.time) }}</q-item-label>
            <q-item-label class="text-weight-medium text-dark">{{ booking.object.customer.name }}
            </q-item-label>
            <q-item-label class="text-weight-medium text-dark">{{ booking.object.customer.contact_no }}</q-item-label>
          </q-item-section>
        </q-card-section>
        <q-card-section class="q-py-none q-px-none">
          <q-markup-table separator="cell" dense>
            <thead>
              <tr>
                <th class="text-left">Service</th>
                <th class="text-left">Therapist</th>
                <th class="text-right">Amount</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(s, sIndex) in booking.object.sales" :key="sIndex">
                <td class="text-left">{{ s.service }}</td>
                <td class="text-left">
                  <div v-if="s.therapists !== 'null'">
                    <div v-for="(val, i) in JSON.parse(s.therapists)" :key="i">
                      {{ findTherapist(val) }}
                    </div>
                  </div>
                  <span v-else>-</span>
                </td>
                <td class="text-right">{{ numberFormat(s.amount) }}</td>
              </tr>
              <tr class="bg-yellow">
                <td class="text-right text-weight-medium" colspan="2">Total Amount</td>
                <td class="text-right text-weight-medium">{{ numberFormat(booking.object.total_amount) }}</td>
              </tr>
              <tr class="">
                <td class="text-right text-weight-medium" colspan="2">DP <span v-if="booking.object.dp_payment_method">/ {{ booking.object.dp_payment_method }}</span></td>
                <td class="text-right text-weight-medium">{{ numberFormat(booking.object.dp) }}</td>
              </tr>
              <tr class="">
                <td class="text-right text-weight-medium" colspan="2">FP <span v-if="booking.object.fp_payment_method">/ {{ booking.object.fp_payment_method }}</span></td>
                <td class="text-right text-weight-medium">{{ numberFormat(booking.object.fp) }}</td>
              </tr>
              <tr class="">
                <td class="text-right text-weight-medium text-red" colspan="2">Balance</td>
                <td class="text-right text-weight-medium text-red">{{ numberFormat(booking.object.total_amount - (booking.object.dp + booking.object.fp)) }}</td>
              </tr>
            </tbody>
          </q-markup-table>
        </q-card-section>

        <q-card-section class="q-pa-sm" v-if="booking.object.status === 'Pending' || booking.object.status === 'Reschedule'">
          <div class="text-center q-pa-md" v-if="booking.preload">
            <q-spinner
              color="green"
              size="3em"
              :thickness="10"
            />
            <div class="q-pt-sm">
              Please wait...
            </div>
          </div>
          <q-list v-else class="text-center text-white">
            <q-item v-if="booking.object.status === 'Pending' || booking.object.status === 'Reschedule'">
              <q-item-section>
                <div class="q-mb-sm">
                    <q-select filled color="dark" label="FP Payment Method" square="" v-model="form.fp_payment_method" :dense="true" :options="['Cash', 'Gcash']" >
                    </q-select>
                    <div class="text-caption text-red" v-if="errors.form.fp_payment_method && errors.show">
                      {{ errors.form.fp_payment_method[0] }}
                    </div>
                  </div>
                  <div>
                    <q-input filled color="dark" label="Final Payment" square="" v-model="form.fp" :dense="true">
                    </q-input>
                    <div class="text-caption text-red" v-if="errors.form.fp && errors.show">
                      {{ errors.form.fp[0] }}
                    </div>
                  </div>
              </q-item-section>
            </q-item>
            <q-item v-if="booking.object.status === 'Pending' || booking.object.status === 'Reschedule'" clickable class="q-ma-md bg-green" @click="updateStatus('Completed')">
              <q-item-section>
                COMPLETED
              </q-item-section>
            </q-item>
            <q-item v-if="booking.object.status === 'Pending' || booking.object.status === 'Reschedule'">
              <q-item-section>
                <div>
                  <q-input filled color="dark" label="Resched Date " square="" v-model="resched.date" :dense="true" type="date">
                  </q-input>
                  <div class="text-caption text-red" v-if="errors.form.reschedule_date && errors.show">
                    {{ errors.form.reschedule_date[0] }}
                  </div>
                </div>
              </q-item-section>
            </q-item>
            <q-item v-if="booking.object.status === 'Pending' || booking.object.status === 'Reschedule'" clickable class="q-ma-md bg-primary" @click="updateStatus('Reschedule')">
              <q-item-section>
                RESCHEDULE
              </q-item-section>
            </q-item>
            <q-item v-if="booking.object.status === 'Pending' || booking.object.status === 'Reschedule'">
              <q-item-section>
                <div>
                  <q-input filled color="dark" label="Voucher Code * " square="" v-model="voucher.code" :dense="true" ></q-input>
                  <div class="text-caption text-red" v-if="errors.form.code && errors.show">
                    {{ errors.form.code[0] }}
                  </div>
                </div>
              </q-item-section>
            </q-item>
            <q-item v-if="booking.object.status === 'Pending' || booking.object.status === 'Reschedule'" clickable class="q-ma-md bg-green" @click="updateStatus('Voucher')">
              <q-item-section>
                COMPLETE USING VOUCHER
              </q-item-section>
            </q-item>
            <q-item v-if="booking.object.status === 'Pending' || booking.object.status === 'Reschedule'" clickable class="q-ma-md bg-red" @click="updateStatus('Cancelled')">
              <q-item-section>
                CANCEL
              </q-item-section>
            </q-item>
          </q-list>
        </q-card-section>
      </q-card>
    </q-dialog>

    <q-dialog v-model="modal" full-width="">
      <q-card>
        <q-card-section class="q-pa-none">
          <form @submit.prevent="store()">
            <q-card-section>
              <div class="text-h6">{{ room }} ({{ dateTimeFormat(date) }})</div>
              <div class="text-caption text-red">
                Required *
              </div>
            </q-card-section>
            <q-separator/>
            <q-card-section>
              <div class="row">
                <div class="col-md-4 q-pa-sm">
                  <div class="q-mb-sm">
                    <q-input filled label="Time" dense v-model="form.time" mask="time" color="dark" readonly>
                      <template v-slot:before>
                        <q-btn icon="access_time" color="dark">
                          <q-popup-proxy cover transition-show="scale" transition-hide="scale">
                            <q-time v-model="form.time">
                              <div class="row items-center justify-end">
                                <q-btn v-close-popup label="Submit" color="primary" flat />
                              </div>
                            </q-time>
                          </q-popup-proxy>
                        </q-btn>
                      </template>
                    </q-input>
                    <div class="text-caption text-red" v-if="errors.form.time && errors.show">
                      {{ errors.form.time[0] }}
                    </div>
                  </div>
                  <div class="q-mb-sm">
                    <q-input filled color="dark" label="Customer Name *" square="" :model-value="customer.object ? customer.object.name : null" :dense="true" readonly>
                      <template v-slot:after>
                        <q-btn icon="search" round color="primary" @click="customer.object = null, customer.rows = [], customer.modal = true" />
                      </template>
                    </q-input>
                    <div class="text-caption text-red" v-if="errors.form.customer && errors.show">
                      {{ errors.form.customer[0] }}
                    </div>
                  </div>
                  <div class="q-mb-sm">
                    <q-select filled color="dark" label="DP Payment Method" square="" v-model="form.dp_payment_method" :dense="true" :options="['Cash', 'Gcash']" >
                    </q-select>
                    <div class="text-caption text-red" v-if="errors.form.dp_payment_method && errors.show">
                      {{ errors.form.dp_payment_method[0] }}
                    </div>
                  </div>
                  <div class="q-mb-sm">
                    <q-input filled color="dark" label="Down Payment" square="" v-model="form.dp" :dense="true">
                    </q-input>
                    <div class="text-caption text-red" v-if="errors.form.dp && errors.show">
                      {{ errors.form.dp[0] }}
                    </div>
                  </div>
                  <div class="q-mb-sm">
                    <q-select filled color="dark" label="FP Payment Method" square="" v-model="form.fp_payment_method" :dense="true" :options="['Cash', 'Gcash']" >
                    </q-select>
                    <div class="text-caption text-red" v-if="errors.form.fp_payment_method && errors.show">
                      {{ errors.form.fp_payment_method[0] }}
                    </div>
                  </div>
                  <div class="q-mb-sm">
                    <q-input filled color="dark" label="Final Payment" square="" v-model="form.fp" :dense="true">
                    </q-input>
                    <div class="text-caption text-red" v-if="errors.form.fp && errors.show">
                      {{ errors.form.fp[0] }}
                    </div>
                  </div>

                  <div class="bg-white text-teal text-right q-mb-sm" v-if="!submitted">
                    <q-btn type="submit" color="green" label="Submit" class="full-width" />
                  </div>
                  <div class="text-center" v-if="submitted">
                    <q-spinner
                      color="primary"
                      size="md"
                      :thickness="10"
                    />
                  </div>

                </div>
                <div class="col-md-4 q-pa-sm">
                  <div class="text-caption text-red" v-if="errors.form.service_orders && errors.show">
                    {{ errors.form.service_orders[0] }}
                  </div>
                  <q-markup-table separator="cell" dense>
                    <thead>
                      <tr class="bg-green text-white">
                        <th colspan="4" class="text-left">
                          SERVICE ORDER
                        </th>
                      </tr>
                      <tr class="bg-grey-2">
                        <th width="10%">-</th>
                        <th class="text-left">Service</th>
                        <th class="text-left">Therapist</th>
                        <th class="text-right">Amount</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="(sl, index) in sale.rows" :key="index">
                        <td>
                          <q-btn icon="close" color="red" @click="removeCart(sl)" size="sm" />
                        </td>
                        <td class="text-left">{{ sl.service }} <span v-if="sl.add_on">(Add-On)</span></td>
                        <td class="text-left">
                          <div v-if="sl.therapists">
                            <div v-for="(val, i) in sl.therapists" :key="i">
                              {{ findTherapist(val) }}
                            </div>
                          </div>
                          <span v-else>-</span>
                        </td>
                        <td class="text-right">{{ numberFormat(sl.amount) }}</td>
                      </tr>
                      <tr class="bg-yellow">
                        <td colspan="3" class="text-right text-weight-bold">TOTAL</td>
                        <td class="text-right text-weight-bold">{{ numberFormat(totalServiceOrder) }}</td>
                      </tr>
                    </tbody>
                  </q-markup-table>
                </div>
                <div class="col-md-4 q-pa-sm">
                  <q-markup-table separator="cell" dense>
                    <thead>
                      <tr class="bg-green text-white">
                        <th colspan="3" class="text-left">
                          SERVICES
                        </th>
                      </tr>
                      <tr class="bg-grey-2">
                        <th width="10%">-</th>
                        <th class="text-left">Service</th>
                        <th class="text-right">Amount</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="(s, index) in service.rows" :key="index">
                        <td>
                          <q-btn label="Add" color="primary" @click="addCart(s)" size="sm" />
                        </td>
                        <td class="text-left" style="white-space: inherit;">{{ s.name }} <span v-if="s.add_on">(Add-On)</span></td>
                        <td class="text-right">{{ numberFormat(s.amount) }}</td>
                      </tr>
                    </tbody>
                  </q-markup-table>
                </div>
              </div>
            </q-card-section>
          </form>
        </q-card-section>
      </q-card>
    </q-dialog>

    <q-dialog v-model="therapist.modal">
    <q-card style="width: 700px; max-width: 80vw;">
      <div>
        <q-list dense>
          <q-item tag="label" v-ripple v-for="(t_row, i) in therapist.rows" :key="i">
            <q-item-section avatar>
              <q-checkbox v-if="sale.duo" v-model="sale.therapists" :val="t_row.id" color="primary" :disable="sale.therapists.length === 2 && !sale.therapists.includes(t_row.id)" />
              <q-checkbox v-else v-model="sale.therapists" :val="t_row.id" color="primary" :disable="sale.therapists.length === 1 && !sale.therapists.includes(t_row.id)" />
            </q-item-section>
            <q-item-section>
              <q-item-label>{{ t_row.name }}</q-item-label>
            </q-item-section>
          </q-item>
        </q-list>
      </div>
      <q-separator/>
      <q-card-section class="text-right q-pa-sm" v-if="sale.therapists.length">
        <template v-if="sale.duo">
          <q-btn label="Submit" color="green" @click="addTherapist()" class="full-width" :disable="sale.therapists.length !== 2" />
        </template>
        <q-btn v-else label="Submit" color="green" @click="addTherapist()" class="full-width" :disable="sale.therapists.length !== 1" />
      </q-card-section>
    </q-card>
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

  </div>
</template>

<script>
import { defineComponent } from 'vue'
import numeral from 'numeral'
import { date } from 'quasar'

export default defineComponent({
  name: 'IndexPage',
  components: {
  },
  data () {
    return {
      preload: true,
      rows: [],
      date: date.formatDate(Date.now(), 'YYYY-MM-DD'),
      room: '',
      modal: false,
      form: {
        room_id: null,
        time: null,
        dp_payment_method: null,
        dp: null,
        fp_payment_method: null,
        fp: null
      },
      errors: {
        show: false,
        form: {
          room_id: null,
          time: null,
          customer: null,
          dp_payment_method: null,
          dp: null,
          fp_payment_method: null,
          fp: null,
          service_orders: null,
          code: null,
          reschedule_date: null
        }
      },
      submitted: false,
      service: {
        preload: true,
        rows: []
      },
      therapist: {
        modal: false,
        preload: true,
        rows: []
      },
      sale: {
        therapists: [],
        service: null,
        amount: null,
        duo: null,
        add_on: null,
        rows: []
      },
      booking: {
        object: null,
        preload: true,
        rows: [],
        modal: false
      },
      customer: {
        search: null,
        object: null,
        preload: true,
        rows: [],
        modal: false
      },
      resched: {
        date: null
      },
      voucher: {
        code: null
      }
    }
  },

  created () {
    this.index()
  },

  methods: {
    numberFormat (param) {
      return numeral(param).format('0,0.00')
    },

    timeFormat (param) {
      const [hours, minutes] = param.split(':')
      const time = new Date()
      time.setHours(hours)
      time.setMinutes(minutes)
      const ampm = time.getHours() >= 12 ? 'PM' : 'AM'
      const hrs = time.getHours() % 12 ? time.getHours() % 12 : 12
      return hrs + ':' + minutes + ' ' + ampm
    },

    dateTimeFormat (param) {
      return date.formatDate(param, 'MMM DD, YYYY')
    },

    filterByRoom (param) {
      return this.booking.rows.filter(v => v.room_id === param)
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

    index () {
      this.date = date.formatDate(Date.now(), 'YYYY-MM-DD')
      this.$api.get('branch/bookings?schedules=1&date=' + this.date, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.booking.rows = response.data
          this.booking.preload = false
        })

      this.$api.get('branch/rooms?active=1', {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.rows = response.data
          this.preload = false
        })

      this.$api.get('branch/services?active=1', {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.service.rows = response.data
          this.service.preload = false
        })

      this.$api.get('branch/therapists?active=1', {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.therapist.rows = response.data
          this.therapist.preload = false
        })
    },

    changeDate () {
      this.booking.preload = true
      this.$api.get('branch/bookings?schedules=1&date=' + this.date, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.booking.rows = response.data
          this.booking.preload = false
        })
    },

    addBooking (param) {
      console.log(param)
      this.form = {
        room_id: param.id,
        time: null,
        dp_payment_method: null,
        dp: null,
        fp_payment_method: null,
        fp: null
      }
      this.sale.rows = []
      this.modal = true
    },

    findTherapist (param) {
      const find = this.therapist.rows.find(v => v.id === param)
      return find.name
    },

    findRoom (param) {
      const find = this.rows.find(v => v.id === param)
      return find.name
    },

    addCart (param) {
      console.log(param)
      if (param.add_on) {
        this.sale.rows.push({
          service: param.name,
          amount: param.amount,
          add_on: param.add_on,
          duo: param.duo,
          therapists: null
        })
      } else {
        this.therapist.modal = true
        this.sale.therapists = []
        this.sale.service = param.name
        this.sale.amount = param.amount
        this.sale.duo = param.duo
        this.sale.add_on = param.add_on
      }
    },

    removeCart (param) {
      this.sale.rows.splice(this.sale.rows.indexOf(param), 1)
    },

    addTherapist () {
      this.sale.rows.push({
        service: this.sale.service,
        amount: this.sale.amount,
        add_on: this.sale.add_on,
        duo: this.sale.duo,
        therapists: this.sale.therapists
      })
      this.therapist.modal = false
    },

    store () {
      this.submitted = true
      this.errors.show = false
      this.$api.post('branch/bookings', {
        date: this.date,
        room_id: this.form.room_id,
        customer: this.customer.object ? this.customer.object.id : null,
        time: this.form.time,
        dp: this.form.dp ?? 0,
        dp_payment_method: this.form.dp_payment_method,
        is_active: 1,
        service_orders: this.sale.rows
      }, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.changeDate()
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

    updateStatus (param) {
      this.booking.preload = true
      this.$api.post('branch/bookings/' + this.booking.object.id, {
        action: 'ChangeStatus',
        fp: this.form.fp,
        fp_payment_method: this.form.fp_payment_method,
        reschedule_date: this.resched.date,
        code: this.voucher.code,
        _method: 'PUT',
        status: param
      }, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          if (param === 'Voucher') {
            this.booking.object.status = 'Completed'
          } else {
            this.booking.object.status = param
          }
          this.booking.modal = false
          this.$q.notify({
            progress: true,
            type: 'positive',
            message: 'Success',
            icon: 'check'
          })
          this.booking.preload = false
        })
        .catch(error => {
          if (error.response.status === 422) {
            this.errors.form = error.response.data.errors
            this.errors.show = true
          }
          this.booking.preload = false
        })
    }
  },

  computed: {
    totalServiceOrder () {
      let total = 0
      this.sale.rows.forEach(v => {
        total += v.amount
      })
      return total
    }
  }
})
</script>

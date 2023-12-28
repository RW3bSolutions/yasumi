<template>
  <q-layout view="hHh lpR lFr">
    <q-header elevated class="bg-green">
      <q-toolbar>
        <q-btn
          flat
          dense
          round
          icon="menu"
          aria-label="Menu"
          @click="toggleLeftDrawer"
        />

        <q-toolbar-title>
          {{ name }}
        </q-toolbar-title>

        <q-btn icon="logout" flat @click="onLogout()" />
      </q-toolbar>
    </q-header>

    <q-drawer
      v-if="!preload"
      class="shadow-1"
      v-model="leftDrawerOpen"
      :width="200"
      show-if-above
    >
      <q-item-label header class="bg-grey-3 text-green">
        <div class="text-caption text-weight-bold">Access: {{ role }}</div>
      </q-item-label>
      <q-list>
        <q-item clickable to="/dashboard" :active-class="$route.name == 'Dashboard' ? 'text-green' : null">
          <q-item-section side>
            <q-icon name="dashboard" :color="$route.name == 'Dashboard' ? 'green' : null" />
          </q-item-section>
          <q-item-section class="text-weight-medium">
            Dashboard
          </q-item-section>
        </q-item>
        <q-item clickable to="/schedules" :active-class="$route.name == 'Schedules' ? 'text-green' : null">
          <q-item-section side>
            <q-icon name="calendar_month" :color="$route.name == 'Schedules' ? 'green' : null" />
          </q-item-section>
          <q-item-section class="text-weight-medium">
            Schedules
          </q-item-section>
        </q-item>
        <q-item clickable to="/customers" :active-class="$route.name == 'Customers' ? 'text-green' : null">
          <q-item-section side>
            <q-icon name="person_search" :color="$route.name == 'Customers' ? 'green' : null" />
          </q-item-section>
          <q-item-section class="text-weight-medium">
            Customers
          </q-item-section>
        </q-item>
        <q-item clickable to="/therapists" :active-class="$route.name == 'Therapists' ? 'text-green' : null">
          <q-item-section side>
            <q-icon name="diversity_1" :color="$route.name == 'Therapists' ? 'green' : null" />
          </q-item-section>
          <q-item-section class="text-weight-medium">
            Therapists
          </q-item-section>
        </q-item>
        <q-item clickable to="/employees" :active-class="$route.name == 'Employees' ? 'text-green' : null" v-if="role === 'Owner'">
          <q-item-section side>
            <q-icon name="people" :color="$route.name == 'Employees' ? 'green' : null" />
          </q-item-section>
          <q-item-section class="text-weight-medium">
            Employees
          </q-item-section>
        </q-item>
        <q-item clickable to="/pay-periods" :active-class="$route.name == 'PayPeriods' ? 'text-green' : null" v-if="role === 'Owner'">
          <q-item-section side>
            <q-icon name="money" :color="$route.name == 'PayPeriods' ? 'green' : null" />
          </q-item-section>
          <q-item-section class="text-weight-medium">
            Payroll
          </q-item-section>
        </q-item>
        <q-item clickable to="/rooms" :active-class="$route.name == 'Rooms' ? 'text-green' : null" v-if="role === 'Owner'">
          <q-item-section side>
            <q-icon name="bed" :color="$route.name == 'Rooms' ? 'green' : null" />
          </q-item-section>
          <q-item-section class="text-weight-medium">
            Rooms
          </q-item-section>
        </q-item>
        <q-item clickable to="/vouchers" :active-class="$route.name == 'Vouchers' ? 'text-green' : null">
          <q-item-section side>
            <q-icon name="loyalty" :color="$route.name == 'Vouchers' ? 'green' : null" />
          </q-item-section>
          <q-item-section class="text-weight-medium">
            Vouchers
          </q-item-section>
        </q-item>
        <q-item clickable to="/sales" :active-class="$route.name == 'Sales' ? 'text-green' : null">
          <q-item-section side>
            <q-icon name="point_of_sale" :color="$route.name == 'Sales' ? 'green' : null" />
          </q-item-section>
          <q-item-section class="text-weight-medium">
            Sales
          </q-item-section>
        </q-item>
        <q-item clickable to="/expenses" :active-class="$route.name == 'Expenses' ? 'text-green' : null">
          <q-item-section side>
            <q-icon name="payments" :color="$route.name == 'Expenses' ? 'green' : null" />
          </q-item-section>
          <q-item-section class="text-weight-medium">
            Expenses
          </q-item-section>
        </q-item>
        <q-item clickable to="/refunds" :active-class="$route.name == 'Refunds' ? 'text-green' : null">
          <q-item-section side>
            <q-icon name="assignment_return" :color="$route.name == 'Refunds' ? 'green' : null" />
          </q-item-section>
          <q-item-section class="text-weight-medium">
            Refunds
          </q-item-section>
        </q-item>
      </q-list>
    </q-drawer>

    <div class="fixed-center text-center" v-if="preload">
      <q-spinner
        color="green"
        size="3em"
        :thickness="10"
      />
      <div class="q-pt-sm">
        Please wait...
      </div>
    </div>

    <q-page-container v-else>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script>
import { defineComponent, ref } from 'vue'

export default defineComponent({
  name: 'MainLayout',

  setup () {
    const leftDrawerOpen = ref(false)
    return {
      leftDrawerOpen,
      toggleLeftDrawer () {
        leftDrawerOpen.value = !leftDrawerOpen.value
      }
    }
  },

  data () {
    return {
      preload: true,
      role: null,
      name: null
    }
  },

  created () {
    this.authGetUser()
  },

  methods: {
    authGetUser () {
      this.$api.get('/user', {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      }).then(response => {
        localStorage.setItem('role', response.data.role)
        if (response.data.portal !== 'Branch') {
          this.onLogout()
        }
        this.name = response.data.branch_access.branch.name
        this.role = response.data.role
        this.preload = false
      })
    },
    onLogout () {
      this.$api.post('/admin/logout', {
      }, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      }).then(response => {
        localStorage.removeItem('token')
        this.$router.push('/')
      }).catch(error => {
        console.log(error)
      })
    }
  }
})
</script>

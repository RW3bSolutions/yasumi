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
          YHS - CMS
        </q-toolbar-title>

        <q-btn icon="logout" flat @click="onLogout()" />
      </q-toolbar>
    </q-header>

    <q-drawer
      class="shadow-1"
      v-model="leftDrawerOpen"
      show-if-above
      :width="200"
    >
      <q-list>
        <q-item clickable to="/dashboard" :active-class="$route.name == 'Dashboard' ? 'text-green' : null">
          <q-item-section side>
            <q-icon name="dashboard" :color="$route.name == 'Dashboard' ? 'green' : null" />
          </q-item-section>
          <q-item-section class="text-weight-medium">
            Dashboard
          </q-item-section>
        </q-item>
        <q-item clickable to="/branches" :active-class="$route.name == 'Branches' ? 'text-green' : null">
          <q-item-section side>
            <q-icon name="store" :color="$route.name == 'Branches' ? 'green' : null" />
          </q-item-section>
          <q-item-section class="text-weight-medium">
            Branches
          </q-item-section>
        </q-item>
        <q-item clickable to="/settings" :active-class="$route.name == 'Settings' ? 'text-green' : null">
          <q-item-section side>
            <q-icon name="settings" :color="$route.name == 'Settings' ? 'green' : null" />
          </q-item-section>
          <q-item-section class="text-weight-medium">
            Settings
          </q-item-section>
        </q-item>
        <!-- <q-item clickable to="/activity-logs" :active-class="$route.name == 'ActivityLogs' ? 'text-green' : null">
          <q-item-section side>
            <q-icon name="history_edu" :color="$route.name == 'ActivityLogs' ? 'green' : null" />
          </q-item-section>
          <q-item-section class="text-weight-medium">
            Activity Logs
          </q-item-section>
        </q-item> -->
      </q-list>
    </q-drawer>

    <q-page-container>
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
        if (response.data.portal !== 'CMS') {
          this.onLogout()
        }
        console.log(response.data)
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

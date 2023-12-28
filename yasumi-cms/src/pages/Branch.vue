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
  <div v-else>
    <div class="q-pa-md">
      <q-breadcrumbs gutter="sm">
        <q-breadcrumbs-el label="Branches" to="/branches" />
        <q-breadcrumbs-el :label="form.name" />
      </q-breadcrumbs>
    </div>

    <BranchTab v-bind:id="$route.params.id" />

    <div>
      <BranchDashboard v-if="!$route.query.page || $route.query.page == 'Dashboard'" />
      <BranchUsers v-if="$route.query.page == 'Users'" />
      <BranchSales v-if="$route.query.page == 'Sales'" />
      <BranchCommissions v-if="$route.query.page == 'Commissions'" />
      <BranchExpenses v-if="$route.query.page == 'Expenses'" />
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import BranchTab from 'components/BranchTab.vue'
import BranchDashboard from 'components/branch-pages/Dashboard.vue'
import BranchUsers from 'components/branch-pages/Users.vue'
import BranchCommissions from 'components/branch-pages/Commissions.vue'
import BranchSales from 'components/branch-pages/Sales.vue'
import BranchExpenses from 'components/branch-pages/Expenses.vue'

export default defineComponent({
  name: 'BranchPage',
  components: {
    BranchTab,
    BranchDashboard,
    BranchUsers,
    BranchSales,
    BranchCommissions,
    BranchExpenses
  },

  data () {
    return {
      preload: true,
      form: null
    }
  },

  created () {
    this.index()
  },

  methods: {
    index () {
      this.$api.get('admin/branches/' + this.$route.params.id, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          console.log(response.data)
          this.form = response.data
          this.preload = false
        })
    }
  }
})
</script>

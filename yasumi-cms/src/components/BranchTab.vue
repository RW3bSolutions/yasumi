<template>
  <q-toolbar class="bg-grey-9 text-white shadow-2 ">
    <q-tabs shrink stretch inline-label indicator-color="transparent">
      <q-route-tab :to="'/branches/' + id + '?page=Dashboard'" exact replace label="Dashboard" />
      <q-route-tab :to="'/branches/' + id + '?page=Users'" exact replace label="Users" />
      <q-route-tab :to="'/branches/' + id + '?page=Commissions'" exact replace label="Commissions" />
      <q-route-tab :to="'/branches/' + id + '?page=Sales'" exact replace label="Sales" />
      <q-route-tab :to="'/branches/' + id + '?page=Expenses'" exact replace label="Expenses" />
    </q-tabs>
  </q-toolbar>
</template>
<script>
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'BranchTab',
  props: {
    id: {
      required: true
    }
  }
})
</script>

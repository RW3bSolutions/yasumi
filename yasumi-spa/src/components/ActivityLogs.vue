<template>
  <q-markup-table dense separator="cell">
    <thead>
      <tr class="bg-green text-white">
        <th width="13.33333%">Date & Time</th>
        <th width="13.33333%">User</th>
        <th width="13.33333%">Action</th>
        <th width="30%">New Data</th>
        <th width="30%">Old Data</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="(row, index) in rows" :key="index">
        <td>{{ dateTimeFormat(row.created_at) }}</td>
        <td>{{ row.user.name }}</td>
        <td>{{ row.event }}</td>
        <td>
          <q-markup-table class="full-width shadow-0 text-left" v-if="JSON.parse(row.properties).attributes">
            <thead>
              <tr v-for="(attrVal, attrKey, i) in JSON.parse(row.properties).attributes" :key="i">
                <th width="50%" class="text-uppercase bg-grey-2">
                  {{ attrKey }}
                </th>
                <th width="50%">
                  {{ attrVal }}
                </th>
              </tr>
            </thead>
          </q-markup-table>
        </td>
        <td>
          <q-markup-table class="full-width shadow-0 text-left" v-if="JSON.parse(row.properties).old">
            <thead>
              <tr v-for="(oldVal, oldKey, i) in JSON.parse(row.properties).old" :key="i">
                <th width="50%" class="text-uppercase bg-grey-2">
                  {{ oldKey }}
                </th>
                <th width="50%">
                  {{ oldVal }}
                </th>
              </tr>
            </thead>
          </q-markup-table>
        </td>
      </tr>
    </tbody>
  </q-markup-table>
</template>
<script>
import { defineComponent } from 'vue'
import { date } from 'quasar'

export default defineComponent({
  name: 'ActivityLogs',
  props: {
    rows: {
      required: true
    }
  },

  methods: {
    dateTimeFormat (param) {
      return date.formatDate(param, 'MMM DD, YYYY - hh:mm a')
    }
  }
})
</script>

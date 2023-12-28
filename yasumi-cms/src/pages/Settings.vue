<template>
  <div>
    <q-list>
      <!-- <q-item clickable to="/services">
        <q-item-section side>
          <q-icon name="arrow_right" />
        </q-item-section>
        <q-item-section>Services</q-item-section>
      </q-item>
      <q-separator/> -->
      <q-item clickable to="/expense-categories">
        <q-item-section side>
          <q-icon name="arrow_right" />
        </q-item-section>
        <q-item-section>Expense Categories</q-item-section>
      </q-item>
      <q-separator/>
    </q-list>
  </div>
</template>

<script>
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'SettingsPage'
})
</script>

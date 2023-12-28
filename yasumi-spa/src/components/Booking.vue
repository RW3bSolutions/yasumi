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
    <q-dialog v-model="modal">
      <q-card>
        <q-card-section>Chard</q-card-section>
      </q-card>
    </q-dialog>
  </div>
</template>

<script>
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'ViewBooking',
  props: {
    id: {
      required: true
    }
  },
  data () {
    return {
      preload: false,
      modal: true
    }
  },

  created () {
  },

  methods: {
  },

  computed: {
  }
})
</script>

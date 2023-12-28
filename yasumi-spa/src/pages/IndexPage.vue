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
    Dashboard
  </div>
</template>

<script>
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'IndexPage',

  data () {
    return {
      preload: false
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

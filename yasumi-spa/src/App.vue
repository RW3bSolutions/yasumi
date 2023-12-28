<template>
  <router-view />
</template>

<script>
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'App',
  created: function () {
    this.$api.interceptors.response.use(
      response => {
        return response
      },
      error => {
        if (error.response.status === 401) {
          localStorage.removeItem('token')
          this.$q.notify({
            type: 'negative',
            message: '401 (Unauthorized)'
          })
          this.$router.push('/')
        } else if (error.response.status === 500) {
          localStorage.removeItem('token')
          this.$q.notify({
            type: 'negative',
            message: '500 (Internal Server Error)'
          })
          this.$router.push('/')
        } else if (error.response.status === 404) {
          this.$q.notify({
            type: 'negative',
            message: '404 (Page Not found)'
          })
          this.$router.push('/404')
        } else {
          return Promise.reject(error)
        }
      })
  }
})
</script>

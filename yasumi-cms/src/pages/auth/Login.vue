<template>
  <q-layout view="lHh Lpr lFf">
    <q-page-container>
      <q-page class="row justify-center items-center">
        <q-form @submit="onLogin()" class=" full-width">
          <div class="row">
            <div class="col-lg-4 offset-lg-4 col-md-6 offset-md-3 col-sm-10 offset-sm-1 col-12">
              <q-card class="no-shadow">
                <q-card-section class="text-center">
                  <!-- <img src="/logo.png" alt=""> -->
                  <div class="text-grey-8 text-weight-medium">YASUMI HEAD SPA</div>
                </q-card-section>
                <q-card-section class="q-pb-none" v-if="errors.data.invalid && errors.show">
                  <div class="bg-red q-pa-md text-white">{{ errors.data.invalid[0] }}</div>
                </q-card-section>
                <q-card-section>
                  <q-input square dense outlined v-model="username" label="Username" autofocus>
                    <template v-slot:prepend>
                      <q-icon name="person" />
                    </template>
                  </q-input>
                  <span class="text-caption text-red" v-if="errors.data.username && errors.show">
                    {{ errors.data.username[0] }}
                  </span>
                  <q-input square dense outlined class="q-mt-md" v-model="password" :type="visibility ? 'text' : 'password'" label="Password">
                    <template v-slot:prepend>
                      <q-icon name="lock" />
                    </template>
                    <template v-slot:append>
                      <q-icon :name="visibility ? 'visibility' : 'visibility_off'" size="xs" @click="visibility = !visibility" />
                    </template>
                  </q-input>
                  <span class="text-caption text-red" v-if="errors.data.password && errors.show">
                    {{ errors.data.password[0] }}
                  </span>
                </q-card-section>
                <!-- <q-card-section class="text-center q-py-none">
                  <div class="text-grey-8">
                    <span class="text-green text-weight-medium cursor-pointer" @click="$router.push('reset-password')"><u>Reset Password</u></span>
                  </div>
                </q-card-section> -->
                <q-card-section class="text-center">
                  <q-spinner-facebook color="green" size="2.25em" v-if="submitted" />
                  <q-btn type="submit" color="green" size="md" label="Sign in" no-caps class="full-width" v-else />
                </q-card-section>
              </q-card>
            </div>
          </div>
        </q-form>
      </q-page>
    </q-page-container>
  </q-layout>
</template>

<script>
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'LoginPage',
  data () {
    return {
      username: 'Admin',
      password: 'password',
      visibility: false,
      errors: {
        show: false,
        data: {
          username: null,
          password: null
        }
      },
      submitted: false
    }
  },

  methods: {
    onLogin () {
      this.submitted = true
      this.$api.post('/admin/login', {
        username: this.username,
        password: this.password
      }).then(response => {
        localStorage.setItem('token', response.data)
        this.$router.push('/dashboard')
        this.submitted = false
      }).catch(error => {
        if (error.response.status === 422) {
          this.errors.data = error.response.data.errors
          this.errors.show = true
          this.submitted = false
        }
      })
    }
  }
})
</script>

<template>
  <q-layout view="lHh Lpr lFf">
    <q-page-container>
      <q-page class="row justify-center items-center">
        <q-form @submit="onResetPassword()" class=" full-width">
          <div class="row">
            <div class="col-lg-4 offset-lg-4 col-md-6 offset-md-3 col-sm-10 offset-sm-1 col-12">
              <q-card class="no-shadow">
                <q-card-section class="text-center">
                  <div class="text-grey-9 text-h5 text-weight-bold">Reset Password</div>
                </q-card-section>
                <q-card-section>
                  <q-input square dense outlined class="q-mt-md" v-model="email" label="Email Address">
                    <template v-slot:append>
                      <span class="text-caption" v-if="countDown">{{ countDown }}</span>
                      <q-btn v-else flat label="SEND OTP" color="green" @click="countDown = 120, sendOTP()" />
                    </template>
                  </q-input>
                  <span class="text-caption text-red" v-if="errors.data.email && errors.show">
                    {{ errors.data.email[0] }}
                  </span>
                  <q-input square dense outlined class="q-mt-md" v-model="otp" label="One Time Pin (OTP)"></q-input>
                  <span class="text-caption text-red" v-if="errors.data.otp && errors.show">
                    {{ errors.data.otp[0] }}
                  </span>
                  <q-input square dense outlined class="q-mt-md" v-model="password" type="password" label="New Password"></q-input>
                  <span class="text-caption text-red" v-if="errors.data.password && errors.show">
                    {{ errors.data.password[0] }}
                  </span>
                </q-card-section>
                <q-card-section class="text-center">
                  <q-spinner-facebook color="dark" size="2.25em" v-if="submitted" />
                  <q-btn type="submit" color="dark" size="md" label="Submit" no-caps class="full-width" v-else />
                </q-card-section>
                <q-card-section class="text-center q-pt-none">
                  <div class="text-grey-8">
                    Already have an account?
                    <span class="text-dark text-weight-bold cursor-pointer" @click="$router.push('/')"><u>Sign In</u></span>
                  </div>
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
      name: null,
      email: null,
      password: null,
      countDown: 0,
      uuid: null,
      otp: null,
      errors: {
        show: false,
        data: {
          name: null,
          email: null,
          password: null
        }
      },
      submitted: false
    }
  },

  methods: {
    sendOTP () {
      this.errors.show = false
      setInterval(() => {
        if (this.countDown !== 0) {
          this.countDown--
        }
      }, 1000)

      this.$api.post('/send-otp', {
        email: this.email
      }).then(response => {
        this.uuid = response.data
      }).catch(error => {
        if (error.response.status === 422) {
          this.countDown = 0
          this.errors.data = error.response.data.errors
          this.errors.show = true
        }
      })
    },
    onResetPassword () {
      this.submitted = true
      this.$api.post('/reset-password', {
        uuid: this.uuid,
        otp: this.otp,
        email: this.email,
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

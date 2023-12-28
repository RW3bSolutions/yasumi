<template>
  <div class="row q-px-md q-py-xs">
    <div class="col-12 col-md-6 q-py-sm self-center">
      <q-breadcrumbs gutter="sm">
        <q-breadcrumbs-el label="Branch Users" class="text-weight-medium" />
      </q-breadcrumbs>
    </div>
    <div class="col-8 col-md-4 q-py-sm q-pr-sm self-center">
      <q-input color="dark" borderless dense debounce="300" v-model="filter" placeholder="Search" filled>
        <template v-slot:append>
          <q-icon name="search" />
        </template>
      </q-input>
    </div>
    <div class="col-4 col-md-2 q-py-sm self-center text-right">
      <q-btn icon="add" label="New" class="full-width" color="green" size="md" @click="create()" />
      <!-- <q-btn icon="refresh" round color="black" size="md" @click="preload = true, index()" /> -->
    </div>
  </div>

  <div class="q-pb-sm q-px-md">
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
    <q-table
      v-else
      square
      :dense="true"
      :rows="rows"
      :columns="columns"
      row-key="index"
      :filter="filter"
      v-model:pagination="pagination"
      :rows-per-page-options="[0]"
      separator="cell"
    >
      <template v-slot:body-cell-no="props">
        <q-td :props="props">
          <div>{{ props.rowIndex + 1 }}</div>
        </q-td>
      </template>
      <template v-slot:body-cell-action="props">
        <q-td :props="props">
          <q-btn-dropdown color="dark" label="Action" size="sm">
            <q-list class="q-pa-xs">
              <q-item clickable v-close-popup @click="edit(props.value)" class="q-pa-xs">
                <q-item-section class="bg-primary text-center text-white">
                  <q-item-label>EDIT</q-item-label>
                </q-item-section>
              </q-item>
            </q-list>
          </q-btn-dropdown>
        </q-td>
      </template>
    </q-table>
  </div>

  <q-dialog v-model="modal">
    <q-card style="width: 700px; max-width: 80vw;">
      <form @submit.prevent="ifEdit ? update() : store()">
        <q-card-section>
          <div class="text-h6">{{ ifEdit ? 'UPDATE USER' : 'NEW USER' }}</div>
          <div class="text-caption text-red">
            Required *
          </div>
        </q-card-section>
        <q-separator/>
        <q-card-section>
          <div class="q-mb-sm">
            <q-input color="dark" label="Username *" square="" v-model="form.username" :dense="true" autofocus="">
              <template v-slot:after v-if="ifEdit">
                <q-toggle
                  size="sm"
                  class="text-caption text-weight-medium"
                  color="green"
                  label="Active"
                  v-model="form.is_active"
                  :true-value="1"
                  :false-value="0"
                />
              </template>
            </q-input>
            <div class="text-caption text-red" v-if="errors.form.username && errors.show">
              {{ errors.form.username[0] }}
            </div>
          </div>
          <div class="q-mb-sm" v-if="!ifEdit">
            <q-input color="dark" label="Password *" square="" v-model="form.password" :dense="true" type="password" />
            <div class="text-caption text-red" v-if="errors.form.password && errors.show">
              {{ errors.form.password[0] }}
            </div>
          </div>
          <div class="q-mb-sm">
            <q-input color="dark" label="Name *" square="" v-model="form.name" :dense="true" />
            <div class="text-caption text-red" v-if="errors.form.name && errors.show">
              {{ errors.form.name[0] }}
            </div>
          </div>
          <div>
            <q-select color="dark" label="Role *" square="" v-model="form.role" :dense="true" :options="['Owner', 'Branch Admin']" />
            <div class="text-caption text-red" v-if="errors.form.role && errors.show">
              {{ errors.form.role[0] }}
            </div>
          </div>
        </q-card-section>
        <q-separator/>
        <q-card-section class="bg-white text-teal" v-if="!submitted">
          <q-btn type="submit" class="full-width" :color="ifEdit ? 'blue' : 'green'" :label="ifEdit ? 'Update' : 'Save'"/>
        </q-card-section>
        <q-card-section class="text-center" v-if="submitted">
          <q-spinner
            color="primary"
            size="md"
            :thickness="10"
          />
        </q-card-section>
        <q-separator/>
      </form>
    </q-card>
  </q-dialog>

</template>

<script>
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'BranchUsersPage',

  data () {
    return {
      preload: true,
      rows: [],
      columns: [
        {
          name: 'name',
          label: 'NAME',
          field: row => row.name,
          align: 'left',
          sortable: true
        },
        {
          name: 'username',
          label: 'USERNAME',
          field: row => row.username,
          align: 'left',
          sortable: true
        },
        {
          name: 'role',
          label: 'ROLE',
          field: row => row.role,
          align: 'left',
          sortable: true
        },
        {
          name: 'is_active',
          label: 'ACTIVE',
          field: row => row.is_active,
          align: 'center',
          style: 'width: 5%'
        },
        {
          name: 'action',
          label: '-',
          field: row => row,
          align: 'center',
          style: 'width: 5%'
        }
      ],
      filter: null,
      pagination: {
        rowsPerPage: 15
      },
      modal: false,
      object: false,
      ifEdit: false,
      ifView: false,
      form: {
        username: null,
        password: null,
        name: null,
        role: null,
        portal: 'Branch',
        is_active: 1
      },
      errors: {
        show: false,
        form: {
          username: null,
          password: null,
          name: null,
          role: null
        }
      },
      submitted: false
    }
  },

  mounted () {
    this.index()
  },

  methods: {
    index () {
      this.$api.get('admin/branch-users?branch_id=' + this.$route.params.id, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.rows = response.data
          this.preload = false
        })
    },
    create () {
      this.modal = true
      this.ifEdit = false
      this.errors.show = false
      this.submitted = false
      this.form.is_active = 1
      this.form.name = null
      this.form.role = null
      this.form.username = null
      this.form.password = null
    },
    store () {
      this.submitted = true
      this.errors.show = false
      this.$api.post('admin/branch-users', {
        branch_id: this.$route.params.id,
        is_active: this.form.is_active,
        portal: this.form.portal,
        name: this.form.name,
        role: this.form.role,
        username: this.form.username,
        password: this.form.password
      }, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.rows.push(response.data)
          this.submitted = false
          this.modal = false
          this.$q.notify({
            progress: true,
            type: 'positive',
            message: 'Success',
            icon: 'check'
          })
        })
        .catch(error => {
          if (error.response.status === 422) {
            this.errors.form = error.response.data.errors
            this.errors.show = true
          }
          this.submitted = false
        })
    },
    edit (param) {
      this.modal = true
      this.ifEdit = true
      this.errors.show = false
      this.submitted = false
      this.object = param
      this.form.is_active = param.is_active
      this.form.name = param.name
      this.form.role = param.role
      this.form.username = param.username
    },
    update () {
      this.submitted = true
      this.errors.show = false
      this.$api.post('admin/branch-users/' + this.object.id, {
        name: this.form.name,
        role: this.form.role,
        username: this.form.username,
        is_active: this.form.is_active,
        _method: 'PUT'
      }, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.object.is_active = this.form.is_active
          this.object.name = this.form.name
          this.object.role = this.form.role
          this.object.username = this.form.username
          this.modal = false
          this.$q.notify({
            progress: true,
            type: 'positive',
            message: 'Success',
            icon: 'check'
          })
        })
        .catch(error => {
          if (error.response.status === 422) {
            this.errors.form = error.response.data.errors
            this.errors.show = true
          }
          this.submitted = false
        })
    },
    destroy (param) {
      this.preload = true
      this.$api.post('admin/branch-users/' + param, {
        _method: 'DELETE'
      }, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(response => {
          this.index()
          this.$q.notify({
            progress: true,
            type: 'positive',
            message: 'Success',
            icon: 'check'
          })
        })
        .catch(error => {
          if (error.response.status === 422) {
            this.errors.form = error.response.data.errors
            this.errors.show = true
          }
          this.preload = false
        })
    }
  }
})
</script>

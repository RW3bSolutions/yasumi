const routes = [
  {
    path: '/',
    component: () => import('pages/auth/Login.vue'),
    meta: {
      requiresAuth: false
    }
  },
  {
    path: '/reset-password',
    component: () => import('pages/auth/ResetPassword.vue'),
    meta: {
      requiresAuth: false
    }
  },
  {
    path: '/main',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      {
        name: 'Dashboard',
        path: '/dashboard',
        component: () => import('pages/IndexPage.vue')
      },
      {
        name: 'Refunds',
        path: '/refunds',
        component: () => import('pages/Refunds.vue')
      },
      {
        name: 'Customers',
        path: '/customers',
        component: () => import('pages/Customers.vue')
      },
      {
        name: 'Schedules',
        path: '/schedules',
        component: () => import('pages/Schedules.vue')
      },
      {
        name: 'Therapists',
        path: '/therapists',
        component: () => import('pages/Therapists.vue')
      },
      {
        name: 'Employees',
        path: '/employees',
        component: () => import('pages/Employees.vue')
      },
      {
        name: 'PayPeriods',
        path: '/pay-periods',
        component: () => import('pages/PayPeriods.vue')
      },
      {
        name: 'Rooms',
        path: '/rooms',
        component: () => import('pages/Rooms.vue')
      },
      {
        name: 'Services',
        path: '/services',
        component: () => import('pages/Services.vue')
      },
      {
        name: 'Vouchers',
        path: '/vouchers',
        component: () => import('pages/Vouchers.vue')
      },
      {
        name: 'Sales',
        path: '/sales',
        component: () => import('pages/Sales.vue')
      },
      {
        name: 'Expenses',
        path: '/expenses',
        component: () => import('pages/Expenses.vue')
      }
    ],
    meta: {
      requiresAuth: true
    }
  },

  // Always leave this as last one,
  // but you can also remove it
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/ErrorNotFound.vue')
  }
]

export default routes

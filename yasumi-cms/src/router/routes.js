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
        name: 'ActivityLogs',
        path: '/activity-logs',
        component: () => import('pages/ActivityLogs.vue')
      },
      {
        name: 'Branches',
        path: '/branches',
        component: () => import('pages/Branches.vue')
      },
      {
        name: 'Branch',
        path: '/branches/:id',
        component: () => import('pages/Branch.vue')
      },
      {
        name: 'Settings',
        path: '/settings',
        component: () => import('pages/Settings.vue')
      },
      {
        name: 'Services',
        path: '/services',
        component: () => import('pages/Services.vue')
      },
      {
        name: 'ExpenseCategories',
        path: '/expense-categories',
        component: () => import('pages/ExpenseCategories.vue')
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

export const routes = [
  { path: '/', redirect: { name: 'Dashboard' } },
  { path: '/dashboard', name: 'Dashboard', component: import('../views/Dashboard.vue') },
]

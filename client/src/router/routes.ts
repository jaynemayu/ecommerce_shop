import { RouteRecordRaw } from 'vue-router'

export const routes: RouteRecordRaw[] = [
  { path: '/', redirect: { name: 'Dashboard' } },
  { path: '/dashboard', name: 'Dashboard', component: () => import('../views/Dashboard.vue') },
  { path: '/shops/new', name: 'ShopNew', component: () => import('../views/ShopNew.vue') },
]

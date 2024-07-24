import { RouteRecordRaw } from 'vue-router'

export const routes: RouteRecordRaw[] = [
  { path: '/', redirect: { name: 'Dashboard' } },
  { path: '/dashboard', name: 'Dashboard', component: () => import('../views/Dashboard.vue') },
  { path: '/products', name: 'Products', component: () => import('../views/Products.vue') },
  { path: '/orders', name: 'Orders', component: () => import('../views/Orders.vue') },
  { path: '/discounts', name: 'Discounts', component: () => import('../views/Discounts.vue') },
  { path: '/shops/new', name: 'ShopNew', component: () => import('../views/ShopNew.vue') }
]

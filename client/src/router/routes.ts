import { RouteRecordRaw } from 'vue-router'

export const routes: RouteRecordRaw[] = [
  { path: '/', redirect: { name: 'Dashboard' } },
  { path: '/dashboard', name: 'Dashboard', component: () => import('../views/DashboardLayout.vue') },
  { path: '/products', name: 'Products', component: () => import('../views/ProductsLayout.vue') },
  { path: '/orders', name: 'Orders', component: () => import('../views/OrdersLayout.vue') },
  { path: '/discounts', name: 'Discounts', component: () => import('../views/DiscountsLayout.vue') },
  { path: '/shops/new', name: 'ShopNew', component: () => import('../views/ShopNewLayout.vue') }
]

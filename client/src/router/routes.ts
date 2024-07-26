import { RouteRecordRaw } from 'vue-router'

const productRoutes: RouteRecordRaw[] = [
  {
    path: '/products',
    component: () => import('../views/OutlineRouterView.vue'),
    redirect: { name: 'Products' },
    children: [{
      path: '',
      name: 'Products',
      component: () => import('../views/products/ProductList.vue')
    }, {
      path: ':id/edit',
      name: 'ProductEdit',
      component: () => import('../views/products/ProductEdit.vue')
    }, {
      path: 'new',
      name: 'ProductNew',
      component: () => import('../views/products/ProductNew.vue')
    }]
  }
]

const orderRoutes: RouteRecordRaw[] = [
  {
    path: '/orders',
    component: () => import('../views/OutlineRouterView.vue'),
    children: [{
      path: '',
      name: 'Orders',
      component: () => import('../views/orders/OrderList.vue')
    }, {
      path: ':id',
      name: 'OrderDetail',
      component: () => import('../views/orders/OrderDetail.vue')
    }]
  }
]

export const routes: RouteRecordRaw[] = [
  { path: '/', redirect: { name: 'Dashboard' } },
  { path: '/dashboard', name: 'Dashboard', component: () => import('../views/dashboard/DashboardView.vue') },
  ...productRoutes,
  ...orderRoutes,
  { path: '/discounts', name: 'Discounts', component: () => import('../views/DiscountList.vue') },
  { path: '/shops/new', name: 'ShopNew', component: () => import('../views/ShopNew.vue') }
]

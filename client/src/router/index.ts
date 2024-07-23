import { createWebHistory, createRouter } from 'vue-router'
import { routes } from './routes'

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, _from, next) => {
  console.log(`Navigating to: ${to.fullPath}`)
  next()
})

export default router

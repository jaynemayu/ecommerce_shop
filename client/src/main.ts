import { createApp, provide, h } from 'vue'
import { createPinia } from 'pinia'
import apolloClient from './apolloClient'
import { DefaultApolloClient } from '@vue/apollo-composable'
import VueApexCharts from 'vue3-apexcharts'
import App from './App.vue'
import router from './router'
import './styles/main.scss'

import { OhVueIcon, addIcons } from 'oh-vue-icons'
import { PrBars, PrSearch, PrPlus, PrCheckSquare, PrFilter, PrTrash, PrCopy, BiArchive, PrArrowLeft, PrDollar, PrShoppingCart, PrShoppingBag, PrStar, PrEllipsisH } from 'oh-vue-icons/icons'

addIcons(PrBars, PrSearch, PrPlus, PrCheckSquare, PrFilter, PrTrash, PrCopy, BiArchive, PrArrowLeft, PrDollar, PrShoppingCart, PrShoppingBag, PrStar, PrEllipsisH)

const app = createApp({
  setup() {
    provide(DefaultApolloClient, apolloClient);
  },
  render: () => h(App),
})
const pinia = createPinia()

app.component('v-icon', OhVueIcon)
app.use(router)
app.use(pinia)
app.use(VueApexCharts)
app.mount('#app')

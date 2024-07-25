import { createApp, provide, h } from 'vue'
import { createPinia } from 'pinia'
import apolloClient from './apolloClient';
import { DefaultApolloClient } from '@vue/apollo-composable';
import App from './App.vue'
import router from './router'
import './styles/main.scss'

import { OhVueIcon, addIcons } from 'oh-vue-icons'
import { PrSearch, PrPlus, PrCheckSquare, PrFilter, PrTrash, PrCopy, BiArchive } from 'oh-vue-icons/icons'

addIcons(PrSearch, PrPlus, PrCheckSquare, PrFilter, PrTrash, PrCopy, BiArchive)

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
app.mount('#app')

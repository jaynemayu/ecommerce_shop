import { createApp, provide, h } from 'vue'
import { createPinia } from 'pinia'
import apolloClient from './apolloClient';
import { DefaultApolloClient } from '@vue/apollo-composable';
import './style.scss'
import App from './App.vue'
import router from './router'

const app = createApp({
  setup() {
    provide(DefaultApolloClient, apolloClient);
  },
  render: () => h(App),
})
const pinia = createPinia()

app.use(router)
app.use(pinia)
app.mount('#app')

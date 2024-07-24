import { createApp, provide, h } from 'vue'
import { createPinia } from 'pinia'
import apolloClient from './apolloClient';
import { DefaultApolloClient } from '@vue/apollo-composable';
import App from './App.vue'
import router from './router'
import './styles/main.scss'

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

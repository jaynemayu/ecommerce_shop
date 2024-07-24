<script setup lang="ts">
import { ref, computed, onMounted, onBeforeUnmount } from 'vue'
import useCurrentUser from '@/composables/useCurrentUser'
import TabsPanel from './components/navigation/TabsPanel.vue'

const {
  currentUser,
  fetchCurrentUser
} = useCurrentUser()

const mobileMenuRef = ref<InstanceType<typeof TabsPanel> | null>(null)
const hamburgerRef = ref<HTMLButtonElement | null>(null)
const showMobileMenu = ref<boolean>(false)

const hideMenuRoutes = ['ShopNew']

const userInitials = computed<string>(() => {
  const firstInitial = currentUser.value?.firstName?.[0] || ''
  const lastInitial = currentUser.value?.lastName?.[0] || ''

  return `${firstInitial}${lastInitial}`
})

const toggleShowMobileMenu = (): void => {
  showMobileMenu.value = !showMobileMenu.value
}

const handleClickOutside = (event: MouseEvent): void => {
  const tabsPanelElement = mobileMenuRef.value?.$el as HTMLElement | undefined
  const hamburgerElement = hamburgerRef.value

  if (tabsPanelElement && !tabsPanelElement.contains(event.target as Node) &&
      hamburgerElement && !hamburgerElement?.contains(event.target as Node)) {
      showMobileMenu.value = false
  }
}

onMounted(() => {
  fetchCurrentUser()
  document.addEventListener('click', handleClickOutside)
})

onBeforeUnmount(() => {
  document.removeEventListener('click', handleClickOutside)
})
</script>
<template>
  <div class="main">
    <div class="main-header">
      <div class="main-header-left">
        <button
          ref="hamburgerRef"
          class="hamburger"
          @click="toggleShowMobileMenu"
        >
          ☰
        </button>
        <h1 @click="() => $router.push({ name: 'Dashboard' })">{{ currentUser.currentShop?.name }}</h1>
      </div>
      <div class="main-header-right">
        <p>Admin Portal</p>
        <div class="main-header-right-user">
          {{ userInitials }}
        </div>
      </div>
    </div>
    <div class="main-content">
      <TabsPanel
        v-if="!hideMenuRoutes.includes($route.name as string)"
        ref="mobileMenuRef"
        :show-mobile-menu="showMobileMenu"
        @hide="() => { showMobileMenu = false }"
      />
      <router-view />
    </div>
  </div>
</template>
<style lang="scss">
@import './styles/app.scss';
</style>

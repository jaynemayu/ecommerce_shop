<script setup lang="ts">
import { computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'

const props = defineProps<{ showMobileMenu: boolean }>()
const emit = defineEmits<{ hide: [] }>()

const route = useRoute()
const router = useRouter()

const isActive = (path: string): boolean => {
  return route.fullPath === path
}

const tabs = computed(() => [{
  name: 'Dashboard',
  isActive: isActive('/dashboard')
}, {
  name: 'Products',
  isActive: isActive('/products')
}, {
  name: 'Orders',
  isActive: isActive('/orders')
}, {
  name: 'Discounts',
  isActive: isActive('/discounts')
}])

const handleTabClick = (name: string): void => {
  router.push({ name })
  emit('hide')
}
</script>
<template>
  <div :class="['tabs-panel', { 'visible': props.showMobileMenu }]">
    <p
      v-for="tab in tabs"
      :key="tab.name"
      :class="['tabs-panel-tab', { 'active' : tab.isActive }]"
      @click="() => handleTabClick(tab.name)"
    >
      {{ tab.name }}
    </p>
  </div>
</template>
<style lang="scss">
@import './tabsPanel.scss';
</style>

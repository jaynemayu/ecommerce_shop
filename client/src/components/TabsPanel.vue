<script setup lang="ts">
import { useRoute } from 'vue-router'

const route = useRoute()

const isActive = (path: string): boolean => {
  return route.fullPath === path
}

const tabs = [{
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
}]

</script>
<template>
  <div class="tabs-panel">
    <p
      v-for="tab in tabs"
      :key="tab.name"
      :class="['tabs-panel-tab', tab.isActive ? 'active' : '']"
      @click="() => $router.push({ name: tab.name })"
    >
      {{ tab.name }}
    </p>
  </div>
</template>

<style lang="scss">
.tabs-panel {
  background-color: #eee;
  min-height: 37.5rem;
  width: 18.75rem;
  border-left: .0625rem solid #ddd;
  border-right: .0625rem solid #ddd;
  &-tab {
    cursor: pointer;
    padding: .625rem 1.25rem;
    border-bottom: .0625rem solid #ddd;
    &.active {
      font-weight: 600;
    }
  }
}
</style>

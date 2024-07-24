<script setup lang="ts">
import TabsPanel from '@/components/TabsPanel.vue'
</script>
<template>
  <div class="orders">
    <TabsPanel />
    <div class="orders-main">
      <h2 class="orders-header">Orders</h2>
      <div class="dashboard-main-section">Main section here</div>
    </div>
  </div>
</template>
<style lang="scss">
.orders {
  display: flex;
  gap: 1.25rem;
  &-main {
    margin-top: 1.25rem;
    &-section {
      margin-top: 1.25rem;
    }
  }
}
</style>

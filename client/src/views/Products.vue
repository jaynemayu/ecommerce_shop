<script setup lang="ts">
import TabsPanel from '@/components/TabsPanel.vue'
</script>
<template>
  <div class="products">
    <TabsPanel />
    <div class="products-main">
      <h2 class="products-header">Products</h2>
      <div class="dashboard-main-section">Main section here</div>
    </div>
  </div>
</template>
<style lang="scss">
.products {
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

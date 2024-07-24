<script setup lang="ts">
import TabsPanel from '@/components/TabsPanel.vue'
</script>
<template>
  <div class="discounts">
    <TabsPanel />
    <div class="discounts-main">
      <h2 class="discounts-header">Discounts</h2>
      <div class="dashboard-main-section">Main section here</div>
    </div>
  </div>
</template>
<style lang="scss">
.discounts {
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

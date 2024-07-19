<script setup lang="ts">
const tabs = ['Dashboard', 'Products', 'Orders', 'Discounts']
</script>
<template>
  <div class="dashboard">
    <div class="dashboard-panel">
      <p
        v-for="tab in tabs"
        :key="tab"
        class="dashboard-panel-tab"
      >
        {{ tab }}
      </p>
    </div>
    <div class="dashboard-main">
      Main section here
    </div>
  </div>
</template>

<style lang="scss">
.dashboard {
  display: flex;
  gap: 1.25rem;
  border-top: .0625rem solid #ddd;
  margin-top: 1.25rem;
  &-panel {
    background-color: #eee;
    min-height: 37.5rem;
    width: 18.75rem;
    border-left: .0625rem solid #ddd;
    border-right: .0625rem solid #ddd;
    &-tab {
      cursor: pointer;
      padding: .625rem 1.25rem;
      border-bottom: .0625rem solid #ddd;
    }
  }
  &-main {
    margin-top: 1.25rem;
  }
}
</style>

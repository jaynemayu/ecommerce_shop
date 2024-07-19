<script setup lang="ts">
</script>
<template>
  <div class="main">
    <div class="main-header">
      <h1>Shop Name</h1>
      <p>Admin Portal</p>
    </div>
    <router-view />
  </div>
</template>
<style lang="scss">
.main {
  &-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
}
</style>

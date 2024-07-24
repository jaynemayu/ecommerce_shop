<script setup lang="ts">
import { provide } from 'vue'
import { DefaultApolloClient } from '@vue/apollo-composable'
import apolloClient from './apolloClient'

provide(DefaultApolloClient, apolloClient)
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
    padding: 0 1.25rem;
    border-bottom: .0625rem solid #ddd;
    padding-bottom: 1.25rem;
  }
}
</style>

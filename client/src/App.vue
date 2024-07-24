<script setup lang="ts">
import { computed, onMounted } from 'vue'
import useCurrentUser from '@/composables/useCurrentUser'

const {
  currentUser,
  fetchCurrentUser
} = useCurrentUser()

const userInitials = computed<string>(() => {
  const firstInitial = currentUser.value?.firstName?.[0] || ''
  const lastInitial = currentUser.value?.lastName?.[0] || ''

  return `${firstInitial}${lastInitial}`
})

onMounted(() => {
  fetchCurrentUser()
})
</script>
<template>
  <div class="main">
    <div class="main-header">
      <h1>Shop Name</h1>
      <div class="main-header-right">
        <p>Admin Portal</p>
        <div class="main-header-right-user">
          {{ userInitials }}
        </div>
      </div>
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
    border-bottom: 1px solid #ddd;
    padding-bottom: 1.25rem;
    &-right {
      display: flex;
      align-items: center;
      gap: 1.25rem;
      &-user {
        display: flex;
        justify-content: center;
        align-items: center;
        border: .125rem solid #ccc;
        border-radius: 50%;
        width: 2rem;
        height: 2rem;
        background-color: #eee;
        cursor: pointer;
      }
    }
  }
}
</style>

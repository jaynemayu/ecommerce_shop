<script setup lang="ts">
import { useRouter } from 'vue-router'
import { ButtonType } from '@/_types/types'
import ActionButton from '@/components/button/ActionButton.vue'

const router = useRouter()

const buttons: ButtonType[] = [
  { title: 'Cancel', type: 'normal', handler: () => router.push({ name: 'ProductList' }) },
  { title: 'Save', type: 'success', handler: () => router.push({ name: 'ProductList' }) }
]
</script>
<template>
  <div class="product">
    <h6 class="product-header">Product Information</h6>
    <div class="product-subheader">
      <div class="product-subheader-actions">
        <ActionButton
          v-for="button in buttons"
          :key="button.title"
          :title="button.title"
          :type="button.type"
          :icon="button.icon"
          @click="button.handler"
        />
      </div>
    </div>
    <div class="product-main">
      <form></form>
      Product form here
    </div>
  </div>
</template>
<style lang="scss">
.product {
  margin: 1.25rem;
  width: 100%;
  &-header {
    @include font-medium;
    @include font-14;
  }
  &-subheader {
    @include row;
    justify-content: space-between;
    align-items: center;
    &-info {
      @include font-12;
      color: $inactive;
    }
    &-actions {
      @include row;
      align-items: center;
      gap: .375rem;
      .search-bar {
        width: 17.5rem;
      }
    }
  }
  &-table {
    margin-top: 1.25rem;
  }
}
</style>

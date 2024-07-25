<script setup lang="ts">
import { useRoute, useRouter } from 'vue-router'
import { formatDateTime } from '@/utils/datetime'
import { ButtonType } from '@/_types/types'
import ActionButton from '@/components/button/ActionButton.vue'
import products from '@/mock_data/products.json'

const route = useRoute()
const router = useRouter()

const id = route.params.id
const idx = Number(id) - 1
const product = products[idx]

const buttons: ButtonType[] = [
  { title: 'Cancel', type: 'normal', handler: () => router.push({ name: 'Products' }) },
  { title: 'Save', type: 'success', handler: () => router.push({ name: 'Products' }) }
]
</script>
<template>
  <div class="product">
    <h6 class="product-header">{{ product.name }}</h6>
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
      <p>Product Information</p>
      <form></form>
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

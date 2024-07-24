<script setup lang="ts">
import { formatDateTime } from '@/utils/datetime'
import { ButtonType } from '@/_types/types'
import DataTable from '@/components/table/DataTable.vue'
import ActionButton from '@/components/button/ActionButton.vue'
import products from '@/mockData/products.json'

const headers: string[] = ['Name', 'Status', 'Price', 'Category', 'Modified', 'Published']
const buttons: ButtonType[] = [
  { title: 'Filter', type: 'normal', handler: () => {} },
  { title: 'Select', type: 'normal', handler: () => {} },
  { title: 'New Product', type: 'success', handler: () => {} }
]
</script>
<template>
  <div class="products">
    <h6 class="products-header">Products</h6>
    <div class="products-subheader">
      <p class="products-subheader-info">
        {{ `${products.length || 0} Products` }}
      </p>
      <div class="products-subheader-actions">
        <input
          class="search-bar"
          id="search"
          name="search"
          type="text"
          placeholder="Search products..."
        />
        <ActionButton
          v-for="button in buttons"
          :key="button.title"
          :title="button.title"
          :type="button.type"
          @click="button.handler"
        />
      </div>
    </div>
    <DataTable
      class="products-table"
      :headers="headers"
    >
      <tr
        v-for="product in products"
        :key="product.id"
      >
        <td>{{ product.name }}</td>
        <td>{{ product.status }}</td>
        <td>{{ product.price }}</td>
        <td>{{ product.category }}</td>
        <td>{{ formatDateTime(product.updatedAt) }}</td>
        <td>{{ formatDateTime(product.createdAt) }}</td>
      </tr>
    </DataTable>
  </div>
</template>
<style lang="scss">
.products {
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

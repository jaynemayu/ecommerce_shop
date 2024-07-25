<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { formatDateTime } from '@/utils/datetime'
import { ProductType as Product, ButtonType } from '@/_types/types'
import { ProductStatus, ProductType } from '@/enums/product'
import DataTable from '@/components/table/DataTable.vue'
import ActionButton from '@/components/button/ActionButton.vue'
import SearchBar from '@/components/search_bar/SearchBar.vue'
import products from '@/mock_data/products.json'

const router = useRouter()

const filteredProducts = ref<Product[]>(products as Product[])

const headers: string[] = ['Name', 'Status', 'Price', 'Category', 'Modified', 'Published']
const buttons: ButtonType[] = [
  { title: 'Filter', type: 'normal', icon: 'pr-filter', handler: () => {} },
  { title: 'Select', type: 'normal', icon: 'pr-check-square', handler: () => {} },
  { title: 'New Product', type: 'success', icon: 'pr-plus', handler: () => router.push({ name: 'ProductNew' }) }
]

const handleSearch = (val: string): void => {
  const searchVal = val.toLowerCase()
  if (!val) {
    filteredProducts.value = products as Product[]
  } else {
    filteredProducts.value = products.filter(product => {
      const nameWords = product.name.toLowerCase().split(' ')

      return nameWords.some(word => word.includes(searchVal))
    }) as Product[]
  }
}

const handleProductClick = (id: string): void => {
  router.push({ name: 'ProductEdit', params: { id } })
}

const getImageUrl = (name: string): string => {
  return new URL(`/src/assets/images/${name}.png`, import.meta.url)?.href
}
</script>
<template>
  <div class="products">
    <h6 class="products-header">Products</h6>
    <div class="products-subheader">
      <p class="products-subheader-info">
        {{ `${filteredProducts.length || 0} Products` }}
      </p>
      <div class="products-subheader-actions">
        <SearchBar
          @update="(val) => handleSearch(val)"
        />
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
    <DataTable
      class="products-table"
      :headers="headers"
    >
      <tr
        v-for="product in filteredProducts"
        :key="product.id"
        @click="() => handleProductClick(product.id)"
      >
        <td>
          <!-- TODO: Add empty image grey rectangle -->
          <img
            :src="getImageUrl(product.image)"
            alt="Product thumbnail"
          />
          <span>{{ product.name }}</span>
        </td>
        <td>{{ ProductStatus[product.status] }}</td>
        <td>{{ product.price }}</td>
        <td>{{ ProductType[product.type] }}</td>
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
    img {
      width: 1.5rem;
    }
    span {
      vertical-align: top;
      margin-left: .375rem;
    }
  }
}
</style>

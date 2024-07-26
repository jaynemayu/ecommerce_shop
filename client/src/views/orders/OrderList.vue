<script setup lang="ts">
import { ref, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { formatDateTime } from '@/utils/datetime'
import { OrderStatus } from '@/enums/order'
import { OrderType as Order, ButtonType } from '@/_types/types'
import DataTable from '@/components/table/DataTable.vue'
import SearchBar from '@/components/search_bar/SearchBar.vue'
import ActionButton from '@/components/button/ActionButton.vue'
import orders from '@/mock_data/orders.json'

const route = useRoute()
const router = useRouter()

const headers = ['Order Number', 'Status', 'Customer', 'Email', 'Date', 'Total']
const buttons: ButtonType[] = [
  { title: 'Select', type: 'normal', icon: 'pr-check-square', handler: () => {} },
  { title: 'Export', type: 'normal', icon: 'la-file-export-solid', handler: () => {} },
]

const getOrders = (): Order[] => {
  // Filter by search
  let ordersShown = orders

  if (search.value) {
    const searchVal = search.value.toLowerCase()
    ordersShown = orders.filter(product => {
      const nameWords = product.orderNumber.toLowerCase().split(' ')

      return nameWords.some(word => word.includes(searchVal))
    }) as Order[]
    console.log(searchVal)
    console.log(ordersShown)
  }

  // Filter by page
  const pageSize = 10
  const startIdx = (page.value - 1) * pageSize
  const endIdx = page.value * pageSize

  return ordersShown.slice(startIdx, endIdx) as Order[]
}
const page = ref<number>(Number(route.query.page || 1))
const search = ref<string>(route.query.search as string)
const filteredOrders = ref<Order[]>(getOrders() as Order[])

// TODO: Do actual fetching
const paginate = (page: number): void => {
  router.push({ name: 'Orders', query: { page } })
}

const handleSearch = (val: string): void => {
  router.push({ name: 'Orders', query: { search: val } })
}

const handleRowClick = (id: string): void => {
  router.push({ name: 'OrderDetail', params: { id } })
}

watch(
  () => route.query,
  () => {
    page.value = Number(route.query.page || 1)
    search.value = route.query.search as string
    filteredOrders.value = getOrders()
  },
  { deep: true }
)
</script>
<template>
  <div class="orders">
    <div class="orders-header">
      <h6 class="header">Orders</h6>
      <div class="orders-header-actions">
        <SearchBar
          @update="(val) => handleSearch(val)"
          placeholder="Search orders..."
        />
        <div class="orders-header-actions-buttons">
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
    </div>
    <DataTable
      class="orders-table"
      :headers="headers"
    >
      <tr
        v-for="order in filteredOrders"
        :key="order.id"
        @click="() => handleRowClick(order.id)"
      >
        <td>{{ order.orderNumber }}</td>
        <td>{{ OrderStatus[order.status] }}</td>
        <td>{{ `${order.customer?.firstName} ${order.customer?.lastName}` }}</td>
        <td>{{ order.customer?.email }}</td>
        <td>{{ formatDateTime(order.createdAt) }}</td>
        <td class="align-right">{{ order.total }}</td>
      </tr>
    </DataTable>
    <div class="orders-pagination">
      <!-- TODO: Clean up implementation -->
      <div class="orders-pagination-page" @click="() => paginate(1)">1</div>
      <div class="orders-pagination-page" @click="() => paginate(2)">2</div>
    </div>
  </div>
</template>
<style lang="scss">
.orders {
  margin: 1.25rem;
  width: 100%;
  &-header {
    @media (min-width: 769px) {
      @include row-between;
    }
    &-actions {
      @include col;
      gap: .625rem;
      max-width: 18.75rem;
      margin-top: .625rem;
      @media (min-width: 769px) {
        @include row;
        align-items: center;
        gap: .375rem;
        max-width: unset;
        margin-top: unset;
      }
      &-buttons {
        @include row;
        align-items: center;
        gap: .375rem;
        .search-bar {
          width: 17.5rem;
        }
      }
    }
  }
  &-table {
    margin-top: 1.25rem;
  }
  &-pagination {
    @include row;
    gap: .625rem;
    margin-top: 1.25rem;
    &-page {
      @include font-12;
      border: .0625rem solid $light-border;
      border-radius: .25rem;
      background-color: #E6E6E6;
      padding: 0 .25rem;
      cursor: pointer;
    }
  }
}
</style>

<script setup lang="ts">
import { ref } from 'vue'
import { formatDateTime } from '@/utils/datetime'
import { OrderStatus } from '@/enums/order'
import { OrderType } from '@/_types/types'
import VueApexCharts from 'vue3-apexcharts'
import DataTable from '@/components/table/DataTable.vue'
import orders from '@/mock_data/orders.json'

const infoGroups = [
  { label: 'Total Sales', value: '48,124 USD', icon: 'pr-dollar' },
  { label: 'Total Orders', value: '436', icon: 'pr-shopping-cart' },
  { label: 'Total Products', value: '23', icon: 'pr-shopping-bag' },
  { label: 'Average Rating', value: '4.5 / 5', icon: 'pr-star' }
]

const headers = ['Order No.', 'Name', 'Email', 'Price', 'Status', 'Ordered On']

const filteredOrders = ref<OrderType[]>(orders as OrderType[])

const columnOptions = {
  dataLabels: {
    enabled: false
  },
  xaxis: {
    categories: ['Aug 23', 'Sep 23', 'Oct 23', 'Nov 23', 'Dec 23', 'Jan 24', 'Feb 24', 'Mar 24', 'Apr 24', 'May 24', 'Jun 24', 'Jul 24'],
  },
  yaxis: {
    title: {
      text: 'Orders'
    }
  }
}
const columnSeries = [{
  data: [10, 18, 9, 4, 6, 11, 3, 11, 44, 32, 11, 44]
}]

const donutOptions = {
  labels: ['Social media', 'Affiliate visitors', 'By advertisement', 'Other']
}
const donutSeries = [41, 24, 32, 3]
</script>
<template>
  <div class="dashboard">
    <h6 class="header">Dashboard</h6>
    <div class="dashboard-main">
      <div class="dashboard-main-section">
        <div
          v-for="group in infoGroups"
          :key="group.label"
          class="dashboard-main-section-box"
        >
          <div :class="['icon-container', group.icon]">
            <v-icon
              :name="group.icon"
              class="dashboard-main-section-box-icon"
            />
          </div>
          <div class="dashboard-main-section-box-info">
            <p class="dashboard-main-section-box-info-label">{{ group.label }}</p>
            <p class="dashboard-main-section-box-info-value">{{ group.value }}</p>
          </div>
        </div>
      </div>
      <div class="dashboard-main-section">
        <div class="dashboard-main-section-box wide">
          <p class="dashboard-main-section-title">Last 12 Months</p>
          <VueApexCharts
            type="bar"
            :width="400"
            :options="columnOptions"
            :series="columnSeries"
          />
        </div>
        <div class="dashboard-main-section-box medium">
          <p class="dashboard-main-section-title">Visitors</p>
          <VueApexCharts
            type="donut"
            :width="400"
            :options="donutOptions"
            :series="donutSeries"
          />
        </div>
      </div>
      <div class="dashboard-main-section">
        <div class="dashboard-main-section-box full">
          <p class="dashboard-main-section-title">Recent Orders</p>
          <DataTable :headers="headers">
            <tr
              v-for="order in filteredOrders"
              :key="order.id"
            >
              <td>{{ order.orderNumber }}</td>
              <td>{{ `${order.customer?.firstName} ${order.customer?.lastName}` }}</td>
              <td>{{ order.customer?.email }}</td>
              <td>{{ order.price }}</td>
              <td>{{ OrderStatus[order.status] }}</td>
              <td>{{ formatDateTime(order.createdAt) }}</td>
            </tr>
          </DataTable>
        </div>
      </div>
    </div>
  </div>
</template>
<style lang="scss">
@import './dashboardView.scss';
</style>

<script setup lang="ts">
const props = defineProps<{
  headers: string[]
}>()
</script>
<template>
  <table class="data-table">
    <thead>
      <tr>
        <th
          v-for="header in props.headers"
          :key="header"
        >
          {{ header }}
        </th>
      </tr>
    </thead>
    <tbody>
      <slot />
    </tbody>
  </table>
</template>
<style lang="scss">
.data-table {
  @include font-12;
  color: $dark-text;
  border-collapse: separate;
  border-spacing: 0;
  width: 100%;
  text-align: left;
  border: .0625rem solid $light-border;
  border-radius: .25rem;
  thead tr:first-child th:first-child {
    border-top-left-radius: .25rem;
  }
  thead tr:first-child th:last-child {
    border-top-right-radius: .25rem;
  }
  tbody tr:last-child td:first-child {
    border-bottom-left-radius: .25rem;
  }
  tbody tr:last-child td:last-child {
    border-bottom-right-radius: .25rem;
  }
  th, td {
    padding: .125rem .375rem;
    height: 1.75rem;
    border: none;
  }
  th {
    @include font-medium;
    background-color: #E6E6E6;
    border-bottom: .0625rem solid $light-border;
  }
  tr {
    background-color: $white;
    &:hover {
      background-color: $light-hover-tint;
    }
  }
}
</style>

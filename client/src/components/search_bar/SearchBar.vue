<script setup lang="ts">
import { ref } from 'vue'

const input = ref<string>('')

const emit = defineEmits<{
  update: [val: string]
}>()

const handleInputChange = (e: Event): void => {
  const value = (e.target as HTMLInputElement)?.value
  input.value = value
  emit('update', value)
}
</script>
<template>
  <div class="search-bar">
    <v-icon name="pr-search" class="search-bar-icon" />
    <input
      class="search-bar-input"
      id="search"
      name="search"
      type="text"
      placeholder="Search products..."
      @input="(e) => handleInputChange(e)"
    />
  </div>
</template>
<style lang="scss">
$icon-padding: .375rem;
$input-padding: 1.5rem;
.search-bar {
  position: relative;
  &-icon {
    position: absolute;
    inset: .5rem;
    left: $icon-padding;
    height: 1rem;
    width: 1rem;
    color: $light-border;
  }
  &-input {
    padding-left: $input-padding;
    width: calc(100% - $input-padding - ($icon-padding / 2));
  }
}
</style>

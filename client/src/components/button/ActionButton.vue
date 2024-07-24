<script setup lang="ts">
import { ButtonTypeType } from '@/_types/types'

const props = defineProps<{
  type: ButtonTypeType
  title: string
}>()
</script>
<template>
  <button :class="['action-button', type]">
    {{ props.title }}
  </button>
</template>
<style lang="scss">
.action-button {
  @include font-12;
  height: 2rem;
  border-radius: .25rem;
  border: .0625rem solid $light-border;
  padding: .125rem 1rem;
  cursor: pointer;
  &.accent {
    background-color: $accent;
    color: $white;
    &:hover {
      background-color: $accent-hover;
    }
  }
  &.normal {
    background-color: $normal;
    color: $dark-text;
    &:hover {
      background-color: $normal-hover;
    }
  }
  &.success {
    background-color: $success;
    color: $white;
    &:hover {
      background-color: $success-hover;
    }
  }
  &.warning {
    background-color: $warning;
    color: $white;
  }
}
</style>

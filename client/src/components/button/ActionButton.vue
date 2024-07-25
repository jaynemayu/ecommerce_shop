<script setup lang="ts">
import { withDefaults } from 'vue'
import { ButtonTypeType } from '@/_types/types'

const props = withDefaults(defineProps<{
  type?: ButtonTypeType
  title?: string
  icon?: string
}>(), {
  type: 'normal'
})
</script>
<template>
  <button :class="['action-button', type]">
    <v-icon
      v-if="icon"
      :name="icon"
      class="action-button-icon"
    />
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
  min-width: 4.375rem;
  cursor: pointer;
  &-icon {
    height: 1rem;
    width: 1rem;
    margin-right: .125rem;
  }
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

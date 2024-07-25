<script setup lang="ts">
import { ref, watch, withDefaults } from 'vue'
import { ButtonType } from '@/_types/types'
import ActionButton from '@/components/button/ActionButton.vue'

const props = withDefaults(defineProps<{
  showActions?: boolean
}>(), {
  showActions: false
})

const emit = defineEmits<{
  update: [formData: {}]
  archive: []
  delete: []
  duplicate: []
}>()

const productTypes = ['Physical', 'Digital', 'Service', 'Advanced']
const buttons: ButtonType[] = [
  { title: 'Delete', type: 'normal', icon: 'pr-trash', handler: () => {} },
  { title: 'Archive', type: 'normal', icon: 'bi-archive', handler: () => {} },
  { title: 'Duplicate', type: 'success', icon: 'pr-copy', handler: () => {} }
]

const formData = ref({
  productType: '',
  name: '',
  slug: '',
  description: '',
  categories: [] as string[],
})
const newCategory = ref<string>('')

const addCategory = (): void => {
  if (newCategory.value && !formData.value.categories.includes(newCategory.value)) {
    formData.value.categories.push(newCategory.value)
    newCategory.value = ''
  }
}

const removeCategory = (index: number): void => {
  formData.value.categories.splice(index, 1)
}

watch(
  formData,
  () => emit('update', formData),
  { deep: true }
)
</script>
<template>
  <div class="product-form-container">
    <form class="product-form">
      <p class="product-form-title">Product Information</p>
      <div class="product-form-fields">
        <div class="form-group">
          <label for="productType">Product Type</label>
          <select v-model="formData.productType" id="productType" required>
            <option v-for="type in productTypes" :key="type" :value="type">{{ type }}</option>
          </select>
        </div>

        <div class="form-group">
          <label for="name">Name</label>
          <input type="text" v-model="formData.name" id="name" required />
        </div>

        <div class="form-group">
          <label for="slug">Slug</label>
          <input type="text" v-model="formData.slug" id="slug" required />
        </div>

        <div class="form-group">
          <label for="description">Description</label>
          <textarea v-model="formData.description" id="description" rows="5"></textarea>
        </div>

        <div class="form-group">
          <label for="categories">Categories</label>
          <div class="categories-input">
            <input
              type="text"
              v-model="newCategory"
              id="categories"
              @keydown.enter.prevent="addCategory"
              placeholder="Add a category and press Enter"
            />
          </div>
          <div class="categories-badges">
            <span v-for="(category, index) in formData.categories" :key="category" class="category-badge">
              {{ category }} <button type="button" @click="removeCategory(index)">x</button>
            </span>
          </div>
        </div>
      </div>

      <div
        v-if="props.showActions"
        class="product-form-actions"
      >
        <ActionButton
          v-for="button in buttons"
          :title="button.title"
          :icon=button.icon
        />
      </div>
    </form>
  </div>
</template>
<style lang="scss">
@import './productForm.scss';
</style>

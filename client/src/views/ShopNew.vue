<script setup lang="ts">
import { useRouter } from 'vue-router'
import useShops from '@/composables/useShops'

const router = useRouter()

const { formData, createShop } = useShops()

const handleSubmit = async () => {
  const success = await createShop(formData.value)

  if (success) {
    console.log('Successfully created shop')
    router.push({ name: 'Dashboard' })
  } else {
    console.log('Failed to create shop')
  }
}
</script>
<template>
  <div class="shop-new">
    <div class="shop-new-header">
      <h2>Create Shop</h2>
    </div>
    <form
      class="shop-new-form"
      @submit.prevent="handleSubmit"
    >
      <div class="form-group">
        <label for="shopName">Shop Name</label>
        <input type="text" id="shopName" v-model="formData.shopName" required />
      </div>
      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" v-model="formData.adminEmail" required />
      </div>
      <div class="form-group">
        <label for="firstName">First Name</label>
        <input type="text" id="firstName" v-model="formData.adminFirstName" required />
      </div>
      <div class="form-group">
        <label for="lastName">Last Name</label>
        <input type="text" id="lastName" v-model="formData.adminLastName" required />
      </div>
      <div class="form-actions">
        <button
          class="normal"
          @click="() => $router.push({ name: 'Dashboard' })"
        >
          Cancel
        </button>
        <button
          class="accent"
          type="submit"
        >
          Create Shop
        </button>
      </div>
    </form>
  </div>
</template>

<style lang="scss">
.shop-new {
  display: flex;
  flex-direction: column;
  align-items: center;
  &-header {
    margin: 1.25rem;
  }
  &-form {
    width: 37.5rem;
    .form-group {
      display: flex;
      gap: .625rem;
      align-items: center;
      margin-top: 1.25rem;
      label {
        width: 10rem;
      }
    }
    .form-actions {
      display: flex;
      justify-content: center;
      gap: 1.25rem;
    }
  }
}
</style>

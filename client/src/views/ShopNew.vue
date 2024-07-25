<script setup lang="ts">
import { useRouter } from 'vue-router'
import useShops from '@/composables/useShops'
import ActionButton from '@/components/button/ActionButton.vue'

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
        <ActionButton
          title="Cancel"
          @click="() => $router.push({ name: 'Dashboard' })"
        />
        <ActionButton
          type="accent"
          title="Submit"
          @click="handleSubmit"
        />
      </div>
    </form>
  </div>
</template>

<style lang="scss">
.shop-new {
  @include col-center;
  width: 100%;
  &-header {
    margin: 1.25rem;
  }
  &-form {
    width: 37.5rem;
    .form-group {
      @include row-center;
      gap: .625rem;
      margin-top: 1.25rem;
      label {
        width: 10rem;
      }
      input {
        width: 100%;
      }
    }
    .form-actions {
      @include row-center;
      gap: 1.25rem;
      margin-top: 1.25rem;
    }
  }
}
</style>

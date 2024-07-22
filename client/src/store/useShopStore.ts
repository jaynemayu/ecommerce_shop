import { ref, Ref } from 'vue'
import { defineStore } from 'pinia'
import gql from 'graphql-tag'
import { useQuery, useMutation } from '@vue/apollo-composable'

// Set up type gen
interface AdminType {
  firstName: string
  lastName: string
}

interface ShopType {
  id: string
  name: string
  admins: AdminType[]
}

interface ShopsQueryVariablesType {
  page: number
  perPage: number
}

interface CreateShopVariablesType {
  shopName: string
  adminEmail: string
  adminFirstName: string
  adminLastName: string
}

const shopsGql = gql`
  ${require('./graphql/shops/shops.graphql').default}`
const createShopGql = gql`
  ${require('./graphql/shops/createShop.graphql').default}`

export const useShopStore = defineStore('shop', () => {
  const loading = ref(false)

  const shops = ref<ShopType[]>([]) as Ref<ShopType[]>

  // Queries
  const fetchShops = async (variables: ShopsQueryVariablesType): Promise<boolean> => {
    try {
      loading.value = true
      const { result, error } = useQuery(shopsGql, { variables })

      if (error) {
        console.error(error)
        
        return false
      }

      

      shops.value = result.value.shops as ShopType[]
  
      return true
    } catch (error) {
      console.error(error)

      return false
    } finally {
      loading.value = false
    }
  }

  // Mutations
  const createShop = async (variables: CreateShopVariablesType): Promise<boolean> => {
    try {
      loading.value = true

      const { mutate, error } = useMutation(createShopGql)

      if (error) {
        console.error(error)

        return false
      }

      await mutate(variables)

      return true
    } catch (error) {
      console.error(error)

      return false
    } finally {
      loading.value = false
    }
  }

  return {
    loading,
    shops,
    fetchShops,
    createShop
  }
})

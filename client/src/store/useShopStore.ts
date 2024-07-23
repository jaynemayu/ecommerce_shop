import { ref, Ref } from 'vue'
import { defineStore } from 'pinia'
import { useApolloClient } from '@vue/apollo-composable'
import { ShopType, ShopsQueryVariablesType, CreateShopVariablesType } from '@/_types/types'
import shopsGql from '@/graphql/shops/shops.graphql'
import createShopGql from '@/graphql/shops/createShop.graphql'

export const useShopStore = defineStore('shop', () => {
  const client = useApolloClient().client

  const loading = ref(false)

  const shops = ref<ShopType[]>([]) as Ref<ShopType[]>

  // Queries
  const fetchShops = async (variables: ShopsQueryVariablesType): Promise<boolean> => {
    try {
      loading.value = true
      const { data, errors } = await client.query({
        query: shopsGql,
        variables
      })

      if (errors) {
        console.error('Query Error:', errors)
        
        return false
      }

      shops.value = data.shops as ShopType[]
  
      return true
    } catch (error) {
      console.error('Catch Query Error:', error)

      return false
    } finally {
      loading.value = false
    }
  }

  // Mutations
  const createShop = async (variables: CreateShopVariablesType): Promise<boolean> => {
    try {
      loading.value = true

      const { errors } = await client.mutate({
        mutation: createShopGql,
        variables
      })

      if (errors) {
        console.error('Mutation Error:', errors)

        return false
      }

      return true
    } catch (error) {
      console.error('Catch Mutation Error:', error)

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

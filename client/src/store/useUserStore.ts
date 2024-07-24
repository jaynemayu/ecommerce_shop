import { ref } from 'vue'
import { defineStore } from 'pinia'
import { useApolloClient } from '@vue/apollo-composable'
import { CurrentUserType } from '@/_types/types'
import currentUserGql from '@/graphql/users/currentUser.graphql'

export const useUserStore = defineStore('user', () => {
  const client = useApolloClient().client

  const loading = ref(false)

  const currentUser = ref<CurrentUserType>({} as CurrentUserType)

  // Queries
  const fetchCurrentUser = async (): Promise<boolean> => {
    try {
      loading.value = true
      const { data, errors } = await client.query({
        query: currentUserGql
      })

      if (errors) {
        console.error('Query Error:', errors)
        
        return false
      }

      currentUser.value = data.currentUser as CurrentUserType
  
      return true
    } catch (error) {
      console.error('Catch Query Error:', error)

      return false
    } finally {
      loading.value = false
    }
  }

  return {
    loading,
    currentUser,
    fetchCurrentUser
  }
})

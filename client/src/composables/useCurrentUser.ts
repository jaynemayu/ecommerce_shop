import { Ref } from 'vue'
import { storeToRefs } from 'pinia'
import { useUserStore } from '@/store/useUserStore'
import { CurrentUserType } from '@/_types/types'

interface UseShops {
  currentUser: Ref<CurrentUserType>
  fetchCurrentUser: () => Promise<boolean>
}

const useCurrentUser = (): UseShops => {
  const userStore = useUserStore()
  const { fetchCurrentUser } = userStore
  const { currentUser } = storeToRefs(userStore)

  return {
    currentUser,
    fetchCurrentUser
  }
}

export default useCurrentUser

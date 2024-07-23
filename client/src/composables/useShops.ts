import { ref, Ref } from 'vue'
import { storeToRefs } from 'pinia'
import { useShopStore } from '@/store/useShopStore'
import { ShopType, CreateShopVariablesType } from '@/_types/types'

interface UseShops {
  formData: Ref<CreateShopVariablesType>
  shops: Ref<ShopType[]>
  handleFetchShops: () => Promise<boolean>
  createShop: (variables: CreateShopVariablesType) => Promise<boolean>
}

const useShops = (): UseShops => {
  const shopStore = useShopStore()
  const { fetchShops, createShop } = shopStore
  const { shops } = storeToRefs(shopStore)

  const formData = ref<CreateShopVariablesType>({
    shopName: '',
    adminEmail: '',
    adminFirstName: '',
    adminLastName: ''
  })

  const page = 1
  const perPage = 10

  const handleFetchShops = (): Promise<boolean> => fetchShops({ page, perPage })

  return {
    shops,
    formData,
    handleFetchShops,
    createShop
  }
}

export default useShops

import { ref, Ref } from 'vue'
import { storeToRefs } from 'pinia'
import { useProductStore } from '@/store/useProductStore'
import { ProductType, CreateProductVariablesType } from '@/_types/types'

interface UseProducts {
  formData: Ref<CreateProductVariablesType>
  products: Ref<ProductType[]>
  handleFetchProducts: () => Promise<boolean>
  createProduct: (variables: CreateProductVariablesType) => Promise<boolean>
}

const useProducts = (): UseProducts => {
  const productStore = useProductStore()
  const { fetchProducts, createProduct } = productStore
  const { products } = storeToRefs(productStore)

  const formData = ref<CreateProductVariablesType>({
    name: '',
    slug: '',
    status: 'unpublished',
    price: { amount: '', currency: 'USD' },
    productType: '',
    categories: [],
    description: ''
  })

  const page = 1
  const perPage = 10

  const handleFetchProducts = (): Promise<boolean> => fetchProducts({ page, perPage })

  return {
    products,
    formData,
    handleFetchProducts,
    createProduct
  }
}

export default useProducts

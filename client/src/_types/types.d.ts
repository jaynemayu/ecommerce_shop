export interface AdminType {
  firstName: string
  lastName: string
}

export interface ShopType {
  id: string
  name: string
  admins: AdminType[]
}

export interface ShopsQueryVariablesType {
  page: number
  perPage: number
}

export interface CreateShopVariablesType {
  shopName: string
  adminEmail: string
  adminFirstName: string
  adminLastName: string
}

export interface CurrentUserType {
  id: string
  email: string
  firstName: string
  lastName: string
  role: {
    id: string
    name: string
    level: number
  }
  currentShop: {
    id: string
    name: string
  }
}

export type ButtonTypeType = 'normal' | 'accent' | 'warning' | 'success' | 'disabled'

export interface ButtonType {
  title: string
  type: ButtonTypeType
  icon?: string
  handler: () => any
}

export interface ProductType {
  id: string
  name: string
  slug: string
  status: 'published' | 'unpublished' | 'archived'
  price: string
  type: 'physical' | 'digital' | 'service' | 'advanced'
  categories: string[]
  image: string
  updatedAt: number
  createdAt: number
}

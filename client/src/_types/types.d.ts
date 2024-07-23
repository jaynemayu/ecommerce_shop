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

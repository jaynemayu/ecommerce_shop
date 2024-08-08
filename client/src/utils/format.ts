import { PriceType } from '@/_types/types'

// TODO: Add options for showing symbol vs currency
export const formatPrice = ({ amount, currency }: PriceType): string => {
  const formattedAmount = Number(amount).toFixed(2)
  return `${currency} ${formattedAmount}`
}

import dayjs from 'dayjs'
import utc from 'dayjs/plugin/utc'
import timezone from 'dayjs/plugin/timezone'

dayjs.extend(utc)
dayjs.extend(timezone)

const userTimeZone = dayjs.tz.guess()

export const formatDateTime = (
  timestamp: number,
  format: string = 'MMM D, YYYY h:mm A',
): string => {
  const date = dayjs(timestamp * 1000)

  return date.tz(userTimeZone).format(format)
}

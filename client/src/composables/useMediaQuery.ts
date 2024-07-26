import { ref, onMounted, onUnmounted } from 'vue'

const useMediaQuery = (query: string) => {
  const matches = ref(false)

  const updateMatches = (event: MediaQueryListEvent) => {
    matches.value = event.matches
  }

  let mediaQueryList: MediaQueryList

  onMounted(() => {
    mediaQueryList = window.matchMedia(query)
    matches.value = mediaQueryList.matches
    mediaQueryList.addEventListener('change', updateMatches)
  })

  onUnmounted(() => {
    mediaQueryList.removeEventListener('change', updateMatches)
  })

  return matches
}

export default useMediaQuery

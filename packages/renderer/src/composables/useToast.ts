import type { ComponentInstance } from '@nuxtjs/composition-api'
import type { Toasted } from 'vue-toasted'

type  Root  =  ComponentInstance & { $toast: Toasted }

export default function useToast(root: Root){
  return root.$toast
}
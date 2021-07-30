<template>
  <div class="flex" text-center>
    <div class="main" text-center>
      <h1 class="display-2 font-weight-bold mb-3">Intuiter</h1>
      <svg v-on:click="run" class="liquid-button" />
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted } from '@vue/composition-api'
import { useStore } from '@nuxtjs/composition-api'
import DancingButton from 'dancing-button'
import { Store } from 'vuex'

import { useToast } from '~/composables/useToast'
import { State } from '~/store/'

export default defineComponent({
  setup(_, context) {
    const store: Store<State> = useStore()
    const toast = useToast(context.root)

    // Run Command
    async function run() {
      toast.success('Intuiter Running')
      toast.info('You can close Window')
    }

    onMounted(() => {
      const button = document.querySelector('.liquid-button')
      new DancingButton(button)
    })
    return { run }
  }
})
</script>

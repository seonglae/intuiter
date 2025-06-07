<template>
  <div class="flex" text-center>
    <div class="main" text-center>
      <div v-for="(d, i) in digits" :key="d" class="mb-2">
        <v-text-field v-model="paths[i]" :label="`Win+${d}`" />
      </div>
      <v-btn color="primary" @click="save">Save</v-btn>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, ref } from '@vue/composition-api'
import { remote } from 'electron'
import { resolve } from 'path'
import { promises } from 'fs'
import { useStore } from '@nuxtjs/composition-api'
import ini from 'ini'
import type { Store } from 'vuex'
import type { State } from '~/store/'

const INI_PATH = 'resources\\default.ini'

export default defineComponent({
  setup(_, ctx) {
    const store: Store<State> = useStore()
    const digits = ['1','2','3','4','5','6','7','8','9','0']
    const paths = ref<string[]>(Array(10).fill(''))

    onMounted(async () => {
      const root = resolve(remote.app.getAppPath(), '../../')
      const file = resolve(root, INI_PATH)
      try {
        const text = await promises.readFile(file, 'utf8')
        const conf = ini.parse(text)
        const section = conf.custom || {}
        digits.forEach((d, i) => {
          if (section[d]) {
            paths.value[i] = section[d]
            store.commit('setCustomAppPath', { index: i, value: section[d] })
          }
        })
      } catch (error) {
        console.error('Failed to read or parse the INI file:', error)
      }
    })

    async function save() {
      digits.forEach((d, i) => {
        store.commit('setCustomAppPath', { index: i, value: paths.value[i] })
      })
      const root = resolve(remote.app.getAppPath(), '../../')
      const file = resolve(root, INI_PATH)
      const content = ini.stringify({ custom: digits.reduce((o, d, i) => { o[d] = paths.value[i]; return o }, {} ) })
      await promises.writeFile(file, content)
      ctx.root.$toast.success('Saved')
    }

    return { digits, paths, save }
  }
})
</script>

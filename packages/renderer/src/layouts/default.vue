<template>
  <div id="app">
    <nuxt />
    <v-overlay :value="$store.state.loading">
      <v-progress-circular indeterminate size="64" />
    </v-overlay>
  </div>
</template>

<script lang="ts">
import { defineComponent } from '@vue/composition-api'
import '@mdi/font/css/materialdesignicons.css'

export default defineComponent({})
</script>

<style src="~/assets/default.css" />

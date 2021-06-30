<template>
  <div class="flex" text-center>
    <div class="main" text-center>
      <h1>Developing</h1>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from '@vue/composition-api'

export default defineComponent({
  setup() {
    return {}
  }
})
</script>

<style scoped lang="postcss">
.flex {
  height: 100vh;
  display: flex;
}
.main {
  flex: 1 1 auto;
  margin-top: auto;
  margin-bottom: auto;
  padding-bottom: 10rem;
  text-align: center;
}
</style>

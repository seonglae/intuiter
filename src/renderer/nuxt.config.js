// @ts-check

/** @type {import('@nuxt/types').NuxtOptions} */
module.exports = {
  ssr: false,
  target: 'static',
  head: { title: 'intuiter', meta: [{ charset: 'utf-8' }] },
  components: true,
  loading: false,
  buildModules: ['@nuxt/typescript-build', '@nuxtjs/composition-api/module'],
  modules: ['@nuxtjs/vuetify', '@nuxtjs/toast'],
  toast: { position: 'bottom-center', duration: 2000, keepOnHover: true },
  vuetify: { theme: { dark: true } },
}

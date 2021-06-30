module.exports = {
  ssr: false,
  target: 'static',
  head: { title: 'intuiter', meta: [{ charset: 'utf-8' }] },
  components: true,
  loading: false,
  buildModules: ['@nuxt/typescript-build', '@nuxtjs/composition-api/module'],
  modules: ['@nuxtjs/vuetify'],
  vuetify: { theme: { dark: true } },
}

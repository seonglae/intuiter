module.exports = {
  ssr: false,
  target: 'static',
  head: {
    title: 'intuiter',
    meta: [{ charset: 'utf-8' }]
  },
  loading: false,
  plugins: ['@/plugins/icons.js'],
  buildModules: ['@nuxt/typescript-build', '@nuxtjs/composition-api/module'],
  modules: ['@nuxtjs/vuetify'],
  vuetify: {
    theme: { dark: true }
  }
}

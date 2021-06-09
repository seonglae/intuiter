import Vue from 'vue'
import Vuetify from 'vuetify/lib'
import VueCompositionAPI from '@vue/composition-api'

Vue.use(VueCompositionAPI)
Vue.use(Vuetify)

export default new Vuetify({
  icons: { iconfont: 'mdi' },
  theme: { dark: true }
})

import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify'

Vue.config.productionTip = false
configure(require.context('../src', true, /\.stories\.js$/), module);

new Vue({
  vuetify,
  render: h => h(App)
}).$mount('#app')

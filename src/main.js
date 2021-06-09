import Vue from 'vue'
import App from './pages/index.vue'
import vuetify from './plugins/vuetify'

Vue.config.productionTip = false

new Vue({ vuetify, render: h => h(App) }).$mount('#app')

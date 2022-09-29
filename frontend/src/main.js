import Vue from 'vue'
import App from './App'
import router from './router'
import vuetify from '@/plugins/vuetify'
import 'mdb-vue-ui-kit/css/mdb.min.css';

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify,
    router,
    render: h => h(App)
  }).$mount('#app')
  document.body.appendChild(app.$el)

  console.log(app)
})
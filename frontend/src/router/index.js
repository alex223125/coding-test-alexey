// recordstore-frontend/router/index.js

import Vue from 'vue'
import Router from 'vue-router'
import Reports from '@/components/Reports.vue'
import Findings from '@/components/Findings.vue'


Vue.use(Router)

export default new Router({
    mode: 'history',
    routes: [
        {
            path: '/reports',
            name: 'Reports',
            component: Reports
        },
        {
            path: '/findings',
            name: 'Findings',
            component: Findings
        }
    ]
})
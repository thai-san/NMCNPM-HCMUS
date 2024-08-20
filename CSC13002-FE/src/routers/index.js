import { createRouter, createWebHistory } from 'vue-router';

import Home from '../components/Home.vue';
import Search from '../components/Search.vue';
import Management from '../components/Management.vue';
import About from '../components/About.vue';
import Login from '../components/Login.vue';
import Regulation from '../components/Regulation.vue';
import ResetPassword from '../components/ResetPassword.vue';

const routes = [
    { path: '/', component: Login },
    { path: '/home', component: Home },
    { path: '/login', component: Login },
    { path: '/search', component: Search },
    { path: '/management', component: Management },
    { path: '/regulation', component: Regulation },
    { path: '/about', component: About },
    { path: '/resetpassword', component: ResetPassword },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;

<template>
    <side-bar/>
    <div id="main" class="main-content">
        <router-view></router-view>
    </div>
</template>

<script>
import SideBar from './components/SideBar.vue';
export default { 
    name: 'App',
    components: {
        SideBar,
    },
};
</script>

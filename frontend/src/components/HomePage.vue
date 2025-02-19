<template>
    <h1>Home Page</h1>
    <h2 v-if="user">Welcome, {{ user.name }}</h2>
    <h2 v-else>Welcome</h2>
</template>

<script>
    import {mapState} from 'vuex'

    export default {
        computed: {
            ...mapState(['user'])
        }
    }
</script>
<template>
    <h1>{{ username }}'s Profile'</h1>


    <!-- view, cancel orders, are you sure you want to cancel? -->
    <h2>My Orders</h2>
</template>

<script>

import {computed} from 'vue';
import {useStore} from 'vuex';
import {useRouter} from 'vue-router';
// if not logged in push to login page

// display logged in users name
export default {

     setup() {
        const store = useStore()
        const router = useRouter()

        // check if user is logged in
        const user = computed(()=> store.getters.user)

        if(!user.value || !user.value.name){
            router.push('/login')
        }

        // display logged in user name
        const username = computed(()=>user.value?.name)

        return{
            username
        }
    }
}
   

</script>

<style>

</style>
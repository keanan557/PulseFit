<template>
    <h1>{{ username }}'s Profile'</h1>


    <!-- view, cancel orders, are you sure you want to cancel? -->
    <h2>My Orders</h2>

    <div v-if="loading">Loading...</div>
    <div v-else-if="userOrders.length === 0">No orders found</div>
    

    <table v-else>
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Date</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="order in userOrders" :key="order.order_id">
                <td>{{ order.order_id }}</td>
                <td>{{ new Date(order.order_date).toLocaleString() }}</td>
            </tr>
        </tbody>

    </table>
</template>

<script>

import {computed,ref,onMounted} from 'vue';
import {useStore} from 'vuex';
import {useRouter} from 'vue-router';
// if not logged in push to login page

// display logged in users name
export default {

     setup() {
        const store = useStore()
        const router = useRouter()
        const userOrders = ref([])
        const loading = ref(true)


        // check if user is logged in
        const user = computed(()=> store.getters.user)
        const token = computed(()=> localStorage.getItem('authToken') || store.state.token)

        if(!user.value || !user.value.name){
            router.push('/login')
        }

        // display logged in user name
        const username = computed(()=>user.value?.name)

        onMounted(async () =>{
            try{
                const response = await fetch('http://localhost:3000/api/orders/user', {
                headers: {
                Authorization: `Bearer ${token.value}`,
          },
        })
        if (response.ok) {
          userOrders.value = await response.json();
        } else {
          console.error('Failed to fetch user orders');
          alert('Failed to fetch user orders. Please try again later.'); // User friendly error message
        }


            }catch(error){
                console.error('Error fetching user orders:', error);
        alert('An unexpected error occurred. Please try again later.'); // User friendly error message
      
            }finally{
                loading.value = false;
            }
        })

        return{
            username,
            userOrders,
            loading
        }
    }
}
   

</script>

<style>

</style>
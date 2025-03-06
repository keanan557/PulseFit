<template>
    <h1>{{ username }}'s Profile'</h1>


    <!-- view, cancel orders, are you sure you want to cancel? -->
    <h2>My Orders</h2>

    <div v-if="loading">Loading...</div>
    <div v-else-if="userOrders.length === 0">No orders found</div>
    

    <table v-else border="1px">
        <thead>
            <tr>
                <th>Name</th>
                <th>Order ID</th>
                <th>Display</th>
                <th>Date</th>
                
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="order in userOrders" :key="order.order_id">
                <td>{{ order.user_name }}</td>
                <td>{{ order.order_id }}</td>

                <td>
            <ul>
              <li v-for="item in order.items" :key="item.product_id">
                <img :src="item.image" alt="Product Image" class="order-img">
              </li>
            </ul>
          </td>

                <td>{{ new Date(order.order_date).toLocaleString() }}</td>
                <button @click="confirmCancel(order.order_id)">Cancel</button>
            </tr>
        </tbody>

    </table>

    <div class="cancel-order-model" v-if="showCancelModal">
        <h3>Are you sure you want to cancel?</h3>
        <button @click="cancelOrder">Yes</button>
        <button @click="showCancelModal= false">No</button>
    </div>
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
        const orderIdToCancel = ref(null);
        const showCancelModal = ref(false);


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

        const confirmCancel = (orderId) => {
            orderIdToCancel.value = orderId
            showCancelModal.value = true
        }


    const cancelOrder = async () => {
      try {
        console.log("Order ID to cancel:", orderIdToCancel.value);
        console.log("Token:", token.value);

        
        const response = await fetch(
          `http://localhost:3000/api/orders/${orderIdToCancel.value}`,
          {
            method: 'DELETE',
            headers: {
              Authorization: `Bearer ${token.value}`,
            },
          }
        );

        if (response.ok) {
          userOrders.value = userOrders.value.filter(
            (order) => order.order_id !== orderIdToCancel.value
          );
          alert('Order canceled successfully.');
        } else {
          alert('Failed to cancel order.');
        }
      } catch (error) {
        console.error('Error canceling order:', error);
        alert('An error occurred while canceling the order.');
      } finally {
        showCancelModal.value = false;
      }
    };

        return{
            username,
            userOrders,
            loading,
            cancelOrder,
            confirmCancel,
            showCancelModal
        }
    }
}
   

</script>

<style>
.order-img{
    width: 100px;
}



</style>
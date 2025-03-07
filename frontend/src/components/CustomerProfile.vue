<template>
  <div class="customer-profile">
    <h1>{{ username }}'s Profile</h1>
    <br>
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
              <li class="list" v-for="item in order.items" :key="item.product_id">
                <img :src="item.image" alt="Product Image" class="order-img">
              </li>
            </ul>
          </td>
          <td>{{ new Date(order.order_date).toLocaleString() }}</td>
          <button @click="confirmCancel(order.order_id)">Cancel order</button>
        </tr>
      </tbody>
    </table>
    <div class="cancel-order-model" v-if="showCancelModal">
      <h3>Are you sure you want to cancel your order?</h3>
      <button @click="cancelOrder">Yes</button>
      <button @click="showCancelModal= false">No</button>
    </div>
  </div>
</template>
<script>
import { computed, ref, onMounted } from 'vue';
import { useStore } from 'vuex';
import { useRouter } from 'vue-router';
export default {
  setup() {
    const store = useStore();
    const router = useRouter();
    const userOrders = ref([]);
    const loading = ref(true);
    const orderIdToCancel = ref(null);
    const showCancelModal = ref(false);
    // Check if user is logged in
    const user = computed(() => store.getters.user);
    const token = computed(() => localStorage.getItem('authToken') || store.state.token);
    if (!user.value || !user.value.name) {
      router.push('/login');
    }
    // Display logged in user name
    const username = computed(() => user.value?.name);
    onMounted(async () => {
      try {
        const response = await fetch('http://localhost:3000/api/orders/user', {
          headers: {
            Authorization: `Bearer ${token.value}`,
          },
        });
        if (response.ok) {
          userOrders.value = await response.json();
        } else {
          console.error('Failed to fetch user orders');
          alert('Failed to fetch user orders. Please try again later.');
        }
      } catch (error) {
        console.error('Error fetching user orders:', error);
        alert('An unexpected error occurred. Please try again later.');
      } finally {
        loading.value = false;
      }
    });
    const confirmCancel = (orderId) => {
      orderIdToCancel.value = orderId;
      showCancelModal.value = true;
    };
    const cancelOrder = async () => {
      try {
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
    return {
      username,
      userOrders,
      loading,
      cancelOrder,
      confirmCancel,
      showCancelModal,
    };
  },
};
</script>
<style>
/* Ensure the body and html elements take up the full height */
html, body {
  height: 100%;
  margin: 0;
  padding: 0;
}
.customer-profile {
  height: 100%; /* Ensure this container covers the whole viewport */
  background-image: url('@/assets/young-fitness-man-studio_7502-5008.avif'); /* Your background image path */
  background-size: cover; /* Ensure the background image covers the entire screen */
  background-position: center; /* Center the image */
  background-repeat: no-repeat; /* Prevent repeating the image */
  font-family: Arial, sans-serif;
  color: #000000;
  padding: 20px;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
  justify-content: flex-start; /* Keep the content aligned to the top */
}
h1 {
  color: #CC0000;
  text-align: center;
}
/* Table styling */
table {
  width: 80%;
  margin: 40px auto;
  border-collapse: collapse;
  font-size: 16px;
  background-color: #fff;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  overflow: hidden;
  justify-content: center;
}
th,
td {
  padding: 15px;
  text-align: left;
  border-bottom: 1px solid #ddd;
  justify-content: center;
}
th {
  background-color: #0C0C0C;
  color: white;
  font-weight: bold;
  text-transform: uppercase;
}
tbody tr:nth-child(even) {
  background-color: #F9F9F9;
}
.list{
  text-decoration: none;
  list-style: none;
}
tbody tr:hover {
  background-color: #F1F1F1;
  cursor: pointer;
}
tbody tr:hover td {
  color: #000;
}
h2 {
  text-align: center;
  text-decoration: underline;
  margin-top: 40px;
  margin-bottom: 20px;
  font-size: 24px;
  color: #FFFFFF;
}
.order-img {
  width: 80px;
  height: auto;
  border-radius: 5px;
}
.cancel-order-model {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: white;
  padding: 20px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  z-index: 1000;
  width: 300px;
  text-align: center;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center; /* Center content inside the modal */
}
.cancel-order-model h3 {
  margin-bottom: 20px;
  color: #333;
}
/* Button Styling */
button {
  background-color: #FF0000;
  color: rgb(255, 255, 255);
  border: none;
  padding: 10px 20px;
  font-size: 16px;
  font-family: 'Franklin Gothic Medium';
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  margin: 5px;
}
button:hover {
  background-color: #CC0000;
}
button:focus {
  outline: none;
}
button.cancel {
  background-color: #F44336;
  justify-self: center;
  justify-content: center;
}
button.cancel:hover {
  background-color: #D32F2F;
}
</style>
<template>
  <div class="admin-container">
    <!-- Header Section -->
    <div class="header">
      <h1></h1>
      <div class="user-info">
      </div>
    </div>
    <!-- order table -->
    <h2 class="text-xl font-bold">Orders List</h2>
    <div v-if="loading">Loading...</div>
    <div v-else-if="orders.length === 0">No orders found.</div>
    <table v-else class="table-auto w-full border-collapse border border-gray-300 mt-4">
      <thead>
        <tr class="bg-gray-200">
          <th class="border px-4 py-2">Order ID</th>
          <th class="border px-4 py-2">User</th>
          <th class="border px-4 py-2">Email</th>
          <th class="border px-4 py-2">Product</th>
          <th class="border px-4 py-2">Address</th>
          <th class="border px-4 py-2">Image</th>
          <th class="border px-4 py-2">Quantity</th>
          <th class="border px-4 py-2">Date</th>
          <th class="border px-4 py-2">Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="order in orders" :key="order.order_id" class="text-center">
          <td class="border px-4 py-2">{{ order.order_id }}</td>
          <td class="border px-4 py-2">{{ order.user_name }}</td>
          <td class="border px-4 py-2">{{ order.user_email }}</td>
          <td class="border px-4 py-2">
            <ul>
              <li class="list" v-for="item in order.items" :key="item.product_id">
                {{ item.name }} - x{{ item.quantity }}
              </li>
            </ul>
          </td>
          <td class="border px-4 py-2">
            <p v-if="order.shipping_address">
              <span v-if="order.shipping_address.fullName">{{ order.shipping_address.fullName }},</span>
              <span v-if="order.shipping_address.address">{{ order.shipping_address.address }},</span>
              <span v-if="order.shipping_address.city">{{ order.shipping_address.city }},</span>
              <span v-if="order.shipping_address.zipCode">{{ order.shipping_address.zipCode }},</span>
              <span v-if="order.shipping_address.country">{{ order.shipping_address.country }}</span>
            </p>
            <p v-else>No Address Provided</p>
          </td>
          <td class="border px-4 py-2">
            <ul>
              <li class="list" v-for="item in order.items" :key="item.product_id">
                <img :src="item.image" alt="Product Image" class="w-16 h-16 object-cover mx-auto order-img">
              </li>
            </ul>
          </td>
          <td class="border px-4 py-2">{{ order.total_price }}</td>
          <td class="border px-4 py-2">{{ new Date(order.order_date).toLocaleString() }}</td>
          <td>
            <button @click="deleteOrder(order.order_id)" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-700">Delete</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
// import jwt
import jwtDecode from 'jwt-decode';
export default {
  data() {
    return {
      orders: [],
      loading: true,
      username: ''
    };
  },
  created() {
    // get token
    const token = localStorage.getItem('authToken');
    if (token) {
      try {
        const decoded = jwtDecode(token);
        this.username = decoded.username;
      } catch (error) {
        console.error('Token decoding failed:', error);
      }
    } else {
      this.$router.push('/AdminLogin');
    }
  },
  mounted() {
    this.fetchOrders();
  },
  // methods
  methods: {
    // api
    async fetchOrders() {
      try {
        const response = await fetch("http://localhost:3000/api/orders");
        const data = await response.json();
        this.orders = data;
      } catch (error) {
        console.error("Error fetching orders:", error);
      } finally {
        this.loading = false;
      }
    },
    async deleteOrder(orderId){
      if (!confirm("Are you sure you want to delete this order?")) return;
      try {
        const response = await fetch(`http://localhost:3000/api/orders/${orderId}`, {
          method: "DELETE",
        });
        if (!response.ok) {
          throw new Error("Failed to delete order");
        }
        this.orders = this.orders.filter(order => order.order_id !== orderId);
      } catch (error) {
        console.error("Error deleting order:", error);
      }
    }
  }
};
</script>
<style scoped>
/* styles */
.admin-container {
  padding: 20px;
}
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: linear-gradient(to right, red, black);  color: white;
  padding: 15px;
  border-radius: 8px;
  margin-bottom: 0px;
  margin-top: 0px;
}
.user-info {
  font-weight: bold;
}
.list {
  list-style: none;
}
.table-auto th,
.table-auto td {
  padding: 12px;
  text-align: center;
  border: 1px solid #ddd;
}
.order-img {
  width: 60px;
  height: 60px;
  object-fit: cover;
}
</style>
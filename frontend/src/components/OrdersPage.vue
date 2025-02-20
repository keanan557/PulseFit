<template>
    <div>
      <h2 class="text-xl font-bold">Orders List</h2>
      <table class="table-auto w-full border-collapse border border-gray-300 mt-4">
        <thead>
          <tr class="bg-gray-200">
            <th class="border px-4 py-2">Order ID</th>
            <th class="border px-4 py-2">User</th>
            <th class="border px-4 py-2">Product</th>
            <th class="border px-4 py-2">Image</th>
            <th class="border px-4 py-2">Quantity</th>
            <th class="border px-4 py-2">Date</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="order in orders" :key="order.order_id" class="text-center">
            <td class="border px-4 py-2">{{ order.order_id }}</td>
            <td class="border px-4 py-2">{{ order.user_name }}</td>
            <td class="border px-4 py-2">{{ order.product_name }}</td>
            <td class="border px-4 py-2">
              <img :src="'/images/' + order.product_image" alt="Product Image" class="w-16 h-16 object-cover mx-auto">
            </td>
            <td class="border px-4 py-2">{{ order.quantity }}</td>
            <td class="border px-4 py-2">{{ new Date(order.order_date).toLocaleString() }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </template>
  <script>
  export default {
    data() {
      return {
        orders: [],
      };
    },
    mounted() {
      this.fetchOrders();
    },
    methods: {
      async fetchOrders() {
        try {
          const response = await fetch("http://localhost:3000/api/orders");
          this.orders = await response.json();
        } catch (error) {
          console.error("Error fetching orders:", error);
        }
      },
    },
  };
  </script>
  <style scoped>
  h2 {
    margin-bottom: 10px;
  }
  </style>
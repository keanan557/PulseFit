<template>
  <div>
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
              <li v-for="item in order.items" :key="item.product_id">
                {{ item.name }} - x{{ item.quantity }}
              </li>
            </ul>
          </td>
          <td class="border px-4 py-2">
            <p v-if="order.shipping_address">
              <span v-if="order.shipping_address.fullName && order.shipping_address.fullName.trim()">
                {{ order.shipping_address.fullName.trim() }},
              </span>
              <span v-if="order.shipping_address.address && order.shipping_address.address.trim()">
                {{ order.shipping_address.address.trim() }},
              </span>
              <span v-if="order.shipping_address.city && order.shipping_address.city.trim()">
                {{ order.shipping_address.city.trim() }},
              </span>
              <span v-if="order.shipping_address.zipCode && order.shipping_address.zipCode.trim()">
                {{ order.shipping_address.zipCode.trim() }},
              </span>
              <span v-if="order.shipping_address.country && order.shipping_address.country.trim()">
                {{ order.shipping_address.country.trim() }}
              </span>
            </p>
            <p v-else>No Address Provided</p>
          </td>
          <td class="border px-4 py-2">
            <ul>
              <li v-for="item in order.items" :key="item.product_id">
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
export default {
  data() {
    return {
      orders: [],
      loading: true,
    };
  },
  mounted() {
    this.fetchOrders();
  },
  methods: {
    async fetchOrders() {
      try {
        const response = await fetch("http://localhost:3000/api/orders");
        const data = await response.json();
        console.log("Fetched orders", data);
        this.orders = data.map(order => {
          if (order.shipping_address) {
            try {
              order.shipping_address = JSON.parse(order.shipping_address);
            } catch (error) {
              console.error("Error parsing shipping_address:", error);
              // Handle parsing error (e.g., set shipping_address to null or an empty object)
              order.shipping_address = null;
            }
          }
          return order;
        });
      } catch (error) {
        console.error("Error fetching orders:", error);
      } finally {
        this.loading = false;
      }
    },

    async deleteOrder(orderId){
      if (!confirm("Are you sure you want to delete this order?")) return; // Confirmation dialog

try {
  const response = await fetch(`http://localhost:3000/api/orders/${orderId}`, {
    method: "DELETE",
  });

  if (!response.ok) {
    throw new Error("Failed to delete order");
  }

  // Remove deleted order from UI
  this.orders = this.orders.filter(order => order.order_id !== orderId);
} catch (error) {
  console.error("Error deleting order:", error);
}
    }



  },
};
</script>

<style scoped>
/* Admin Container */
.admin-container {
  background-color: #000;
  color: #fff;
  padding: 20px;
  font-family: Arial, sans-serif;
}

/* Header */
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 2px solid red;
  padding-bottom: 20px;
}

.header h1 {
  color: red;
  margin-left: 20px;  /* Added margin to move it slightly to the right */
}

/* Search Bar */
.search-container {
  display: flex;
  align-items: center;
  justify-content: center;
  max-width: 400px;
  margin: 20px auto;
  padding: 5px;
  background-color: #f9f9f9;
  border-radius: 25px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.search-input {
  flex-grow: 1;
  padding: 10px;
  border: none;
  border-radius: 25px;
  font-size: 16px;
  outline: none;
}

.search-btn {
  background-color: transparent;
  border: none;
  cursor: pointer;
  padding: 8px;
  margin-left: 10px;
}

.search-btn svg {
  fill: #333;
  width: 20px;
  height: 20px;
  transition: fill 0.3s ease;
}

.search-btn:hover svg {
  fill: #e60000;
}

/* Orders Table */
.orders-table h2 {
  color: red;
  margin-bottom: 20px;
}

.product-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

.product-table th,
.product-table td {
  padding: 12px;
  text-align: center;
  border: 1px solid #ddd;
}

.product-image {
  width: 50px;
  height: 50px;
  object-fit: cover;
  border-radius: 8px;
}

.product-table th {
  background-color: #f3f3f3;
  color: #333;
}

/* Hover effect for table rows */
.product-table tr:hover {
  background-color: #f9f9f9;
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

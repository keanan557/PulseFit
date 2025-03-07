<template>
  <div class="admin-container">
    <!-- Header Section -->
    <div class="header">
      <h1>Admin Dashboard</h1>
      <div class="user-info">
        <span v-if="username">Welcome, {{ username }}</span>
      </div>
    </div>
    <!-- Dashboard Overview Section -->
    <div class="dashboard-overview">
      <div class="dashboard-card">
        <h3>Products</h3>
        <p>{{ uniqueProductsCount }} Products Ordered</p>
      </div>
      <div class="dashboard-card">
        <h3>Orders</h3>
        <p>{{ totalOrders }} Pending Orders</p>
      </div>
      <div class="dashboard-card">
        <h3>Customers</h3>
        <p>{{ uniqueCustomersCount }}</p>
      </div>
    </div>
    <!-- Orders Management Section -->
    <div class="orders-management">
      <h2>Order Management</h2>
      <div v-if="loading">Loading...</div>
      <div v-else-if="orders.length === 0">No orders found.</div>
      <table v-else class="orders-table">
        <thead>
          <tr>
            <th>Order ID</th>
            <th>User</th>
            <th>Email</th>
            <th>Product</th>
            <th>Address</th>
            <th>Image</th>
            <th>Amount</th>
            <th>Date</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="order in orders" :key="order.order_id" class="text-center">
            <td>{{ order.order_id }}</td>
            <td>{{ order.user_name }}</td>
            <td>{{ order.user_email }}</td>
            <td>
              <ul>
                <li class="list" v-for="item in order.items" :key="item.product_id">
                  {{ item.name }} - x{{ item.quantity }}
                </li>
              </ul>
            </td>
            <td>
              <p v-if="order.shipping_address">
                <span v-if="order.shipping_address.fullName">{{ order.shipping_address.fullName }}</span>,
                <span v-if="order.shipping_address.address">{{ order.shipping_address.address }}</span>,
                <span v-if="order.shipping_address.city">{{ order.shipping_address.city }}</span>,
                <span v-if="order.shipping_address.zipCode">{{ order.shipping_address.zipCode }}</span>,
                <span v-if="order.shipping_address.country">{{ order.shipping_address.country }}</span>
              </p>
              <p v-else>No Address Provided</p>
            </td>
            <td>
              <ul>
                <li class="list" v-for="item in order.items" :key="item.product_id">
                  <img :src="item.image" alt="Product Image" class="w-16 h-16 object-cover mx-auto order-img" />
                </li>
              </ul>
            </td>
            <td>{{ order.total_price }}</td>
            <td>{{ new Date(order.order_date).toLocaleString() }}</td>
            <td>
              <button @click="processOrder(order)" class="btn">
                Process
              </button>
              <button @click="deleteOrder(order.order_id)" class="btn">
                Delete
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <!-- Processing Pop-Up -->
    <div v-if="isProcessing" class="popup-overlay">
      <div class="popup">
        <p>{{ processingMessage }}</p>
      </div>
    </div>
  </div>
</template>
<script>
import jwtDecode from 'jwt-decode';
export default {
  data() {
    return {
      orders: [],
      loading: true,
      username: '',
      totalOrders: 0, // Initialize total orders count
      uniqueProductsCount: 0, // Initialize the unique products count
      uniqueCustomersCount: 0, // Initialize unique customers count
      isProcessing: false, // State to control pop-up visibility
      processingMessage: 'Please wait while your request is being put through', // Initial message
    };
  },
  created() {
    const token = localStorage.getItem('authToken');
    if (token) {
      try {
        const decoded = jwtDecode(token);
        this.username = decoded.username; // Set username from decoded token
      } catch (error) {
        console.error('Token decoding failed:', error);
      }
    } else {
      this.$router.push('/AdminLogin');
    }
  },
  mounted() {
    this.fetchOrders(); // Fetch orders on mount
  },
  methods: {
    logout() {
      localStorage.removeItem('authToken');
      this.$router.push('/AdminLogin');
    },
    async fetchOrders() {
      try {
        const response = await fetch('http://localhost:3000/api/orders');
        const data = await response.json();
        this.orders = data.map(order => {
          // Handle shipping address parsing
          if (order.shipping_address) {
            try {
              order.shipping_address = JSON.parse(order.shipping_address);
            } catch (error) {
              console.error('Error parsing shipping_address:', error);
              order.shipping_address = null;
            }
          }
          return order;
        });
        // Update the total number of orders
        this.totalOrders = this.orders.length;
        // Calculate the number of unique products ordered
        this.calculateUniqueProducts();
        // Calculate the number of unique customers
        this.calculateUniqueCustomers();
      } catch (error) {
        console.error('Error fetching orders:', error);
      } finally {
        this.loading = false;
      }
    },
    calculateUniqueProducts() {
      // Use a Set to track unique product IDs
      const productIds = new Set();
      this.orders.forEach(order => {
        order.items.forEach(item => {
          productIds.add(item.product_id); // Add product ID to the Set
        });
      });
      // Set size gives the number of unique products ordered
      this.uniqueProductsCount = productIds.size;
    },
    calculateUniqueCustomers() {
      // Use a Set to track unique customer emails
      const customerEmails = new Set();
      this.orders.forEach(order => {
        customerEmails.add(order.user_email); // Add customer email to the Set
      });
      // Set size gives the number of unique customers
      this.uniqueCustomersCount = customerEmails.size;
    },
    async deleteOrder(orderId) {
      if (!confirm('Are you sure you want to delete this order?')) return;
      try {
        const response = await fetch(`http://localhost:3000/api/orders/${orderId}`, {
          method: 'DELETE',
        });
        if (!response.ok) {
          throw new Error('Failed to delete order');
        }
        // Remove the deleted order from UI
        this.orders = this.orders.filter(order => order.order_id !== orderId);
        // Update the total number of orders and unique products count
        this.totalOrders = this.orders.length;
        this.calculateUniqueProducts();
        this.calculateUniqueCustomers();
      } catch (error) {
        console.error('Error deleting order:', error);
      }
    },
    async processOrder(order) {
      this.isProcessing = true; // Show the pop-up
      // Step 1: Show initial message
      this.processingMessage = 'Please wait while your request is being put through...';
      // Step 2: Change message after 2 seconds
      setTimeout(() => {
        this.processingMessage = 'Order will be processed soon!';
      }, 2000);
      // Step 3: Hide the pop-up after 5 seconds
      setTimeout(() => {
        this.isProcessing = false; // Hide the pop-up
      }, 5000);
      try {
        const response = await fetch(`http://localhost:3000/api/orders/${order.order_id}/process`, {
          method: 'PUT',
        });
        if (!response.ok) {
          throw new Error('Failed to process order');
        }
        // Update the total sales by adding the price of this order
        this.totalSales += order.total_price;
        alert('Order processed successfully');
      } catch (error) {
        console.error('Error processing order:', error);
      }
    },
  },
};
</script>
<style scoped>
/* Styles for the Admin Dashboard */
.dashboard-overview {
  display: flex;
  justify-content: space-around;
  margin-top: 30px;
  flex-wrap: wrap;
}
.dashboard-card {
  background: #333;
  color: #fff;
  padding: 15px;
  border-radius: 8px;
  width: 200px;
  text-align: center;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
  margin: 10px;
}
.dashboard-card h3 {
  color: red;
}
.list {
  list-style: none;
}
.btn {
  width: 70%;
}
/* Orders Table */
.orders-table th,
.orders-table td {
  padding: 12px;
  text-align: center;
  border: 1px solid #ddd;
}
.order-img {
  width: 60px;
  height: 60px;
  object-fit: cover;
}
.orders-management {
  margin-top: 30px;
}
button {
  cursor: pointer;
  transition: background-color 0.3s;
}
button:hover {
  background-color: #E63946;
}
.user-info {
  text-align: right;
  color: whitesmoke;
}
/* Pop-Up Overlay */
.popup-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}
/* Pop-Up Box */
.popup {
  background-color: #fff;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
  text-align: center;
}
</style>
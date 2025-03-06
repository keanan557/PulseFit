<template>
  <div class="admin-container">
    <!-- Main Content -->
    <div class="main-content">
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
          <h3>Total Sales</h3>
          <p>500,000</p>
        </div>
        <div class="dashboard-card">
          <h3>Products</h3>
          <p>50 Active Products</p>
        </div>
        <div class="dashboard-card">
          <h3>Orders</h3>
          <p>120 Orders Pending</p>
        </div>
        <!-- <div class="dashboard-card">
          <h3>Customers</h3>
          <p>350 Registered Customers</p>
        </div> -->
      </div>

      <!-- Containers for displaying Orders and Customers tables side by side -->
      <div class="tables-container">
        <!-- Orders Management Section -->
        <div class="orders-management">
          <h2>Order Management</h2>
          <table class="orders-table">
            <thead>
              <tr>
                <th>Order ID</th>
                <th>Customer</th>
                <th>Total Amount</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="order in orders" :key="order.order_id">
                <td>{{ order.order_id }}</td>
                <td>{{ order.customer_name }}</td>
                <td>{{ order.total_amount }}</td>
                <td>{{ order.status }}</td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Customers Management Section
        <div class="customers-management">
          <h2>Customer Management</h2>
          <table class="customers-table">
            <thead>
              <tr>
                <th>Customer ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="customer in customers" :key="customer.customer_id">
                <td>{{ customer.customer_id }}</td>
                <td>{{ customer.name }}</td>
                <td>{{ customer.email }}</td>
                <td>{{ customer.phone }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div> -->

      <!-- Modal for Viewing/Editing Orders -->
      <div v-if="showOrderModal" class="modal">
        <div class="modal-content">
          <h3>{{ isOrderEditing ? 'Edit Order' : 'View Order' }}</h3>
          <label>Customer:</label>
          <input type="text" v-model="order.customer_name" :readonly="!isOrderEditing">
          <label>Total Amount:</label>
          <input type="number" v-model="order.total_amount" :readonly="!isOrderEditing">
          <label>Status:</label>
          <select v-model="order.status" :disabled="!isOrderEditing">
            <option value="Pending">Pending</option>
            <option value="Shipped">Shipped</option>
            <option value="Delivered">Delivered</option>
          </select>
          <div class="modal-actions">
            <button class="save-button" @click="saveOrder">{{ isOrderEditing ? 'Save Changes' : 'Close' }}</button>
            <button class="cancel-button" @click="closeOrderModal">Cancel</button>
          </div>
        </div>
      </div>

      <!-- Modal for Viewing/Editing Customers -->
      <div v-if="showCustomerModal" class="modal">
        <div class="modal-content">
          <h3>{{ isCustomerEditing ? 'Edit Customer' : 'View Customer' }}</h3>
          <label>Name:</label>
          <input type="text" v-model="customer.name" :readonly="!isCustomerEditing">
          <label>Email:</label>
          <input type="email" v-model="customer.email" :readonly="!isCustomerEditing">
          <label>Phone:</label>
          <input type="text" v-model="customer.phone" :readonly="!isCustomerEditing">
          <div class="modal-actions">
            <button class="save-button" @click="saveCustomer">{{ isCustomerEditing ? 'Save Changes' : 'Close' }}</button>
            <button class="cancel-button" @click="closeCustomerModal">Cancel</button>
          </div>
        </div>
      </div>
    </div>
  </div>
  </div>
</template>

<script>
import jwtDecode from 'jwt-decode'; 

export default {
  name: 'AdminHome',
  data() {
    return {
      orders: [], // List of orders to be displayed
      customers: [], // List of customers to be displayed
      showOrderModal: false, // Toggle for order modal visibility
      showCustomerModal: false, // Toggle for customer modal visibility
      order: { order_id: '', customer_name: '', total_amount: 0, status: '' },
      customer: { customer_id: '', name: '', email: '', phone: '' },
      isOrderEditing: false, // Flag for editing an order
      isCustomerEditing: false, // Flag for editing a customer
    };
  },
  created() {
    const token = localStorage.getItem('authToken');
    console.log('Stored token:', token); 
    if (token) {
      try {
        const decoded = jwtDecode(token);
        this.username = decoded.username; // Set username from decoded token
        console.log('Decoded token:', decoded);
      } catch (error) {
        console.error('Token decoding failed:', error);
      }
    } else {
      this.$router.push('/AdminLogin');
    }
  },
  computed: {
    username() {
      return localStorage.getItem('userName') || ''; // Ensure username is fetched correctly
    }
  },
  methods: {
    logout(){
      localStorage.removeItem("authToken");
      this.$router.push("/AdminLogin")
    },
    fetchOrders() {
      fetch('http://localhost:3000/api/orders')
        .then((response) => response.json())
        .then((data) => {
          this.orders = data;
        });
    },
    // fetchCustomers() {
    //   fetch('http://localhost:3000/api/customers')
    //     .then((response) => response.json())
    //     .then((data) => {
    //       this.customers = data;
    //     });
    // },
    viewOrder(order) {
      this.order = { ...order };
      this.isOrderEditing = false;
      this.showOrderModal = true;
    },
    updateOrder(order) {
      this.order = { ...order };
      this.isOrderEditing = true;
      this.showOrderModal = true;
    },
    saveOrder() {
      const method = this.isOrderEditing ? 'PATCH' : 'POST';
      const url = this.isOrderEditing
        ? `http://localhost:3000/api/orders/${this.order.order_id}`
        : 'http://localhost:3000/api/orders';

      fetch(url, {
        method: method,
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(this.order),
      }).then(() => {
        this.fetchOrders();
        this.closeOrderModal();
      });
    },
    deleteOrder(id) {
      fetch(`http://localhost:3000/api/orders/${id}`, { method: 'DELETE' }).then(() => {
        this.fetchOrders();
      });
    },
    closeOrderModal() {
      this.showOrderModal = false;
    },
    // viewCustomer(customer) {
    //   this.customer = { ...customer };
    //   this.isCustomerEditing = false;
    //   this.showCustomerModal = true;
    // },
    // deleteCustomer(id) {
    //   fetch(`http://localhost:3000/api/customers/${id}`, { method: 'DELETE' }).then(() => {
    //     this.fetchCustomers();
    //   });
    // },
    // saveCustomer() {
    //   const method = this.isCustomerEditing ? 'PATCH' : 'POST';
    //   const url = this.isCustomerEditing
    //     ? `http://localhost:3000/api/customers/${this.customer.customer_id}`
    //     : 'http://localhost:3000/api/customers';

    //   fetch(url, {
    //     method: method,
    //     headers: { 'Content-Type': 'application/json' },
    //     body: JSON.stringify(this.customer),
    //   }).then(() => {
    //     this.fetchCustomers();
    //     this.closeCustomerModal();
    //   });
    // },
    // closeCustomerModal() {
    //   this.showCustomerModal = false;
    // },
  },
  mounted() {
    this.fetchOrders();
    // this.fetchCustomers();
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
  margin-left: 20px;
}

/* Dashboard Overview */
.dashboard-overview {
  display: flex;
  justify-content: space-around;
  margin-top: 30px;
}

.dashboard-card {
  background: #333;
  color: #fff;
  padding: 15px;
  border-radius: 8px;
  width: 200px;
  text-align: center;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}

.dashboard-card h3 {
  color: red;
}

/* Containers for displaying both tables side by side */
.tables-container {
  display: flex;
  justify-content: space-between;
  margin-top: 30px;
  gap: 30px;
}

/* Orders and Customers Tables */
.orders-management, .customers-management {
  flex: 1; /* This will make both tables take up equal space */
}

.orders-management h2, .customers-management h2 {
  color: red;
  margin-bottom: 20px;
}

.orders-table, .customers-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

.orders-table th,
.orders-table td,
.customers-table th,
.customers-table td {
  padding: 12px;
  text-align: center;
  border: 1px solid #ddd;
}

/* Modal Styling */
.modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
}

.modal-content {
  background: #fff;
  padding: 20px;
  border-radius: 8px;
  width: 400px;
  color: #000;
  text-align: center;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}

.modal-actions {
  margin-top: 10px;
}

.modal-actions button {
  margin: 5px;
}

input[type="text"],
input[type="number"],
input[type="email"],
select {
  padding: 8px;
  width: 100%;
  margin: 8px 0;
  border: 1px solid #ddd;
  border-radius: 4px;
}

input[type="text"]:focus,
input[type="number"]:focus,
select:focus,
input[type="email"]:focus {
  border-color: red;
}
</style>

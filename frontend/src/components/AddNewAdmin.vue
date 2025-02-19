<template>
    <div>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Password</th>
            <th>Email</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="admin_user in admin_users" :key="admin_user.id">
            <td>{{ admin_user.id }}</td>
            <td>{{ admin_user.username }}</td>
            <td>{{ admin_user.password }}</td>
            <td>{{ admin_user.email }}</td>
            <td>
              <button @click="editAdminUser(admin_user)">Edit</button>
              <button @click="deleteAdminUser(admin_user.id)">Remove</button>
            </td>
          </tr>
        </tbody>
      </table>
      <!-- Modal for Editing -->
      <div v-if="showModal" class="modal">
        <div class="modal-content">
          <h3>Edit Admin User</h3>
          <label>ID: </label>
          <input type="text" v-model="adminUser.id" disabled>
          <br><br>
          <label>Username: </label>
          <input type="text" v-model="adminUser.username">
          <br><br>
          <label>Password: </label>
          <input type="password" v-model="adminUser.password">
          <br><br>
          <label>Email: </label>
          <input type="email" v-model="adminUser.email">
          <br><br>
          <button @click="updateAdminUser">Save Changes</button>
          <button @click="closeModal">Cancel</button>
        </div>
      </div>
      <!-- Add Admin User Form -->
      <div class="add-form">
        <h3>Add Admin User</h3>
        <label>Username: </label>
        <input type="text" v-model="newAdminUser.username" required>
        <br><br>
        <label>Password: </label>
        <input type="password" v-model="newAdminUser.password" required>
        <br><br>
        <label>Email: </label>
        <input type="email" v-model="newAdminUser.email" required>
        <br><br>
        <button @click="addAdminUser">Add User</button>
      </div>
    </div>
  </template>
  <script>
  export default {
    data() {
      return {
        admin_users: [],  // Array of admin users to be fetched
        showModal: false,  // Control modal visibility
        adminUser: { id: '', username: '', password: '', email: '' }, // Admin user data for editing
        newAdminUser: { username: '', password: '', email: '' },  // New admin user data for adding
      };
    },
    methods: {
      // Fetch admin users from the API
      async fetchAdminUsers() {
        const response = await fetch('http://localhost:3000/api/admin_users');
        if (response.ok) {
          this.admin_users = await response.json();
        }
      },
      // Edit an admin user and show the modal
      editAdminUser(adminUser) {
        this.adminUser = { ...adminUser };
        this.showModal = true;
      },
      // Update the admin user data
      async updateAdminUser() {
        const response = await fetch(`http://localhost:3000/api/admin_users/${this.adminUser.id}`, {
          method: 'PATCH',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(this.adminUser),
        });
        if (response.ok) {
          this.fetchAdminUsers();
          this.showModal = false;
        }
      },
      // Delete an admin user
      async deleteAdminUser(id) {
        const response = await fetch(`http://localhost:3000/api/admin_users/${id}`, { method: 'DELETE' });
        if (response.ok) this.fetchAdminUsers();
      },
      // Add a new admin user
      async addAdminUser() {
        const response = await fetch('http://localhost:3000/api/admin_users', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(this.newAdminUser),
        });
        if (response.ok) {
          this.fetchAdminUsers();
          this.newAdminUser = { username: '', password: '', email: '' };
        }
      },
      // Close the modal
      closeModal() {
        this.showModal = false;
      },
    },
    mounted() {
      this.fetchAdminUsers();
    },
  };
  </script>
  <style>
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
    background: white;
    padding: 20px;
    border-radius: 5px;
  }
  .add-form {
    margin-top: 20px;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    max-width: 400px;
  }
  </style>







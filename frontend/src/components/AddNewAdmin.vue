<template>
  <div>
    <div class="admin-container">
      <div class="table-container">
        <h3 class="admin-title">Admin User List</h3>
        <div class="table-responsive">
          <table class="admin-table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="admin_user in admin_users" :key="admin_user.id">
                <td>{{ admin_user.id }}</td>
                <td>{{ admin_user.username }}</td>
                <td>{{ admin_user.email }}</td>
                <td>
                  <button class="edit-button" @click="editAdminUser(admin_user)">Edit</button>
                  <button class="remove-button" @click="deleteAdminUser(admin_user.id)">Remove</button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <div class="form-container">
        <h3>Add Admin User</h3>
        <div class="form-group">
          <label for="username">Username: </label>
          <input type="text" v-model="newAdminUser.username" required id="username">
        </div>
        <div class="form-group">
          <label for="password">Password: </label>
          <input type="password" v-model="newAdminUser.password" required id="password">
        </div>
        <div class="form-group">
          <label for="email">Email: </label>
          <input type="email" v-model="newAdminUser.email" required id="email">
        </div>
        <button class="add-button" @click="addAdminUser">Add User</button>
      </div>
    </div>

    <div v-if="showModal" class="modal">
      <div class="modal-content">
        <h3>Edit Admin User</h3>
        <div class="form-group">
          <label>ID: </label>
          <input type="text" v-model="adminUser.id" disabled>
        </div>
        <div class="form-group">
          <label>Username: </label>
          <input type="text" v-model="adminUser.username">
        </div>
        <div class="form-group">
          <label>Email: </label>
          <input type="email" v-model="adminUser.email">
        </div>
        <div class="modal-buttons">
          <button class="save-button" @click="updateAdminUser">Save Changes</button>
          <button class="cancel-button" @click="closeModal">Cancel</button>
        </div>
      </div>
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
  <style scoped>
.admin-container {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding: 20px;
  background-color: #fff;
  color: black;
  flex-wrap: wrap;
}

.admin-title {
  color: red;
  font-size: 2rem;
  text-align: center;
  margin-bottom: 20px;
  width: 100%;
}

.table-container {
  flex: 1;
  margin-top: 20px;
}

.form-container {
  flex: 1;
  background-color: #f8f8f8;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
  margin-top: 20px;
  width: 100%;
  max-width: 400px;
}

.table-responsive {
    overflow-x: auto;
}

.admin-table {
  width: 100%;
  border-collapse: collapse;
}

.admin-table th,
.admin-table td {
  border: 1px solid #ddd;
  padding: 10px;
  text-align: left;
}

.admin-table th {
  background-color: black;
}

.edit-button,
.remove-button,
.add-button,
.save-button,
.cancel-button {
  padding: 8px 12px;
  margin: 5px;
  cursor: pointer;
  border: none;
  border-radius: 4px;
}

.edit-button,
.save-button {
  background-color: white;
  color: black;
  border: 1px solid red;
}

.remove-button,
.cancel-button {
  background-color: #f44336;
  color: white;
}

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
  z-index: 1000;
}

.modal-content {
  background: #f8f8f8;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
  text-align: center;
  color: #000;
  width: 300px;
}

.modal-buttons {
  margin-top: 10px;
}

/* Form styling */
.form-group {
  margin-bottom: 15px;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
}

.form-group input {
  width: 100%;
  padding: 8px;
  margin-top: 5px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .admin-table th,
  .admin-table td {
    padding: 8px;
    font-size: 0.9em;
  }
}

@media (max-width: 576px) {
  .admin-table th,
  .admin-table td {
    padding: 6px;
    font-size: 0.8em;
  }
}
</style>


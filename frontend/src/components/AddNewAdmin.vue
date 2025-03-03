<template>
  <div>
    <div class="admin-container">
      <!-- Admin User Table -->
      <div class="table-container">
        <h3 class="admin-title">Admin User List</h3>
        <table class="admin-table">
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
                <button class="edit-button" @click="editAdminUser(admin_user)">Edit</button>
                <button class="remove-button" @click="deleteAdminUser(admin_user.id)">Remove</button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Add Admin User Form -->
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

    <!-- Modal for Editing -->
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
          <label>Password: </label>
          <input type="password" v-model="adminUser.password">
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
  flex-wrap: wrap; /* Ensures they wrap on smaller screens */
}

.admin-title {
  color: red;
  font-size: 2rem;
  text-align: center; /* Centers the title */
  margin-bottom: 20px;
  width: 100%; /* Makes sure the title spans the full width */
}

.table-container {
  flex: 1;
  margin-top: 20px;
}

.form-container {
  flex: 1;
  background-color: #F8F8F8;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
  margin-top: 20px;
  width: 100%; /* Ensures the form is full-width */
  max-width: 400px; /* Optional: Constrains the form's width */
}

.admin-table {
  width: 100%;
  border-collapse: collapse;
}

.admin-table th, .admin-table td {
  border: 1px solid #000;
  padding: 10px;
  text-align: center;
}

.edit-button, .remove-button, .add-button, .save-button, .cancel-button {
  background-color: red;
  color: white;
  border: none;
  padding: 8px 16px;
  cursor: pointer;
  border-radius: 4px;
  margin: 5px;
}

.edit-button:hover, .remove-button:hover, .add-button:hover, .save-button:hover {
  background-color: #c00;
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
}

.modal-content {
  background: #F8F8F8;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
  text-align: center;
  color: #000;
  width: 400px; /* Optional: Adjust width of modal */
}

.modal-buttons {
  margin-top: 10px;
}

.cancel-button {
  background-color: rgb(243, 8, 8);
}

.cancel-button:hover {
  background-color: rgb(158, 6, 6);
}

/* Form styling */
.form-group {
  margin-bottom: 15px;
}

.form-group label {
  display: block; /* Makes label take up a full line */
  margin-bottom: 5px; /* Adds space below the label */
}

.form-group input {
  width: 100%; /* Ensures the input takes up the full width */
  padding: 8px;
  margin-top: 5px;
  border: 1px solid #ccc;
  border-radius: 4px;
}
</style>


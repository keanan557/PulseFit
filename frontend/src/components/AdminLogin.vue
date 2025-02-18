<template>
    <div>
      <h1>Admin Login</h1>
  
      <!-- Displaying error message if login fails -->
      <div v-if="errorMessage" style="color: red;">
        {{ errorMessage }}
      </div>
  
      <form @submit.prevent="handleLogin">
        <label>Username: </label>
        <input type="text" v-model="username" required />
        <br><br>
  
        <label>Password: </label>
        <input type="password" v-model="password" required />
        <br><br>
  
        <button type="submit">Enter</button>
      </form>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        username: '',
        password: '',
        errorMessage: ''
      };
    },
    mounted() {
      // Check if the user is already logged in by verifying the token
      const token = localStorage.getItem('authToken');
      if (token) {
        // If token exists, redirect to the admin home page
        this.$router.push('/AdminHome');  // Redirect to Admin Home if logged in
      }
    },
    methods: {
        async handleLogin() {
  try {
    // Clear any previous error message
    this.errorMessage = '';

    // Prepare login data
    const loginData = {
      username: this.username,
      password: this.password
    };

    // Make an API request to authenticate the admin user
    const response = await fetch('http://localhost:3000/api/admin/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(loginData)
    });

    const data = await response.json();

    // Check if login was successful
    if (response.ok) {
      // Handle successful login
      // For example, you can store the token in localStorage and redirect to the admin page
      localStorage.setItem('authToken', data.token);  // Assuming the server sends a token
      this.$router.push('/AdminHome');  // Redirect to admin dashboard
    } else {
      // Handle login failure
      this.errorMessage = data.error || 'Invalid login credentials';
    }
  } catch (error) {
    console.error('Error during login:', error);
    this.errorMessage = 'An error occurred. Please try again.';
  }
}

    }
  };
  </script>
  
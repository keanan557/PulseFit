<template>
  <div class="login-wrapper">
    <div class="login-container">
      <form @submit.prevent="handleLogin" class="login-form">
        <h1>Admin Login</h1>
        <!-- Display error message if login fails -->
        <div v-if="errorMessage" class="error-message">
          {{ errorMessage }}
        </div>
        <label>Username:</label>
        <input type="text" v-model="username" required />
        <label>Password:</label>
        <input type="password" v-model="password" required />
        <button type="submit" class="btn">Enter</button>
      </form>
     
    </div>
  </div>
</template>

<script>
import backgroundImage from '@/assets/AL.jpg'; // Ensure this path is correct

export default {
  name: 'LoginPage',
  data() {
    return {
      username: '',
      password: '',
      errorMessage: '',
      backgroundImage: backgroundImage, // Not used in style here, but available if needed
    };
  },
  mounted() {
    // If user is already logged in, redirect to AdminHome
    // const token = localStorage.getItem('authToken');
    // if (token) {
    //   this.$router.push('/AdminHome');
    // }
  },
  methods: {
    async handleLogin() {
      this.errorMessage = '';
      try {
        const response = await fetch('http://localhost:3000/api/admin/login', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ username: this.username, password: this.password }),
        });
        const data = await response.json();
        console.log(data);
        
        if (response.ok) {
          localStorage.setItem('authToken', data.token);
          // Optionally store the user's name if provided
          if (data.username) {
            localStorage.setItem('userName', data.username);
          }
          this.$router.push('/AdminHome');
        } else {
          this.errorMessage = data.error || 'Invalid login credentials';
        }
      } catch (error) {
        console.error('Error during login:', error);
        this.errorMessage = 'An error occurred. Please try again.';
      }
    },
  },
};
</script>

<style scoped>
/* Full-page background */
.login-wrapper {
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  /* Use the background image from your assets */
  background: url('@/assets/AL.jpg') no-repeat center center/cover;
}

/* Login container styling */
.login-container {
  width: 300px;
  padding: 20px;
  border: 1px solid #0d0707;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(255, 255, 255, 0.074);
  text-align: center;
  background-color: rgba(249, 249, 249, 0.308);
  color: #333;
}

/* Form styling */
.login-form {
  display: flex;
  flex-direction: column;
}
.login-form label {
  margin-bottom: 5px;
  font-weight: bold;
  text-align: left;
}
.login-form input {
  padding: 8px;
  margin-bottom: 15px;
  border: 1px solid #4a0a0a;
  border-radius: 5px;
  font-size: 14px;
}

/* Button styling */
.btn {
  padding: 10px;
  background-color: #ff0000;
  color: white;
  border: none;
  border-radius: 5px;
  font-size: 16px;
  cursor: pointer;
  transition: background 0.3s;
}
.btn:hover {
  background-color: red;
}

/* Error message styling */
.error-message {
  color: red;
  margin-bottom: 15px;
  font-weight: bold;
}

/* Register link styling */
.register-link {
  margin-top: 15px;
}
.register-link a {
  color: #000;
  text-decoration: none;
}
.register-link a:hover {
  text-decoration: underline;
}
</style>

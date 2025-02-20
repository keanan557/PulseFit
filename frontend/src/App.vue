<template>
  <!-- Show regular navbar only when you're not on any admin page -->
  <header class="navbar">
  <nav v-if="!isAdminPage" class="nav-links">
    <router-link to="/">Home</router-link> |
    <router-link to="/products">Products</router-link> |
    <router-link to="/cart">Cart</router-link>   |   
    <router-link to="/Login">Login</router-link>
    
    <router-link to="/AdminLogin"><img class="admin_logo" src="/admin_logo.png" alt="Admin Logo" width="100"></router-link>

    <span v-if="isLoggedIn">Welcome, {{ userName }}!</span>
    <button v-if="isLoggedIn" @click="logout">Logout</button>
  </nav>
</header>
  <!-- Show AdminNavbar only on admin pages -->
  <AdminNavbar v-if="isAdminPage" />

  <!-- Always show ProductsList -->
  <RouterView />
</template>

<script>
import AdminNavbar from './components/AdminNavbar.vue';

export default {
  components: { AdminNavbar },
  computed: {
    // Hide regular navbar on admin-related pages
    isAdminPage() {
      const path = this.$route.path;
      return path.startsWith("/AdminHome") ||
       path.startsWith("/AddNewProducts") ||
        path.startsWith("/AdminEditProducts") ||
         path.startsWith("/OrdersPage")
         ||
         path.startsWith("/AddNewAdmin");
    },
    isLoggedIn() {
  return !!this.$store.state.user;
},
userName() {
  return this.$store.state.user ? this.$store.state.user.name : '';
}


  },
  methods: {
    logout() {
      // Clear localStorage and Vuex state
      localStorage.removeItem("authToken");
      localStorage.removeItem("userName");
      this.$store.commit("setUser", null);
      // Optionally redirect to login
      this.$router.push("/login");
    }
  },
  name: 'App',
  
}
</script>

<style>
    .navbar {
    background-color: #000;
    color: white;
    padding: 15px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .navbar .logo {
    font-size: 2rem;
    font-weight: bold;
    color: #E60000; /* Red */
    text-decoration: none;
  }
  .navbar .nav-links a {
    color: white;
    text-decoration: none;
    font-weight: bold;
    margin: 0 15px;
  }
  .navbar .nav-links a:hover {
    color: #E60000; /* Red on hover */
  }

  .admin_logo{
    width: 50px;
    border: 1px solid red;
    border-radius: 50px;
  }
</style>
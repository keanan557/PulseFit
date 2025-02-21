<template>
  <!-- Show regular navbar only when you're not on any admin page -->
  <header class="navbar">
  <nav v-if="!isAdminPage" class="nav-links">
    <router-link to="/">Home</router-link> |
    <router-link to="/products">Products</router-link> |
    <router-link to="/cart" class="cart-link"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
  <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5M3.102 4l1.313 7h8.17l1.313-7zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4m-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2m7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2"/>
</svg>
<span class="cart-badge">{{ cartItemCount }}</span>
</router-link>   |   
    <router-link to="/Login">Login</router-link>
    
    <router-link to="/AdminLogin"><img class="admin_logo"   width="100"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
  <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10s-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664z"/>
</svg></router-link>

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
import { mapGetters } from 'vuex';

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
    ...mapGetters(['cartItemCount']),
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

  .cart-link {
  position: relative;
}

  .cart-badge{
    position: absolute;
  top: -5px;
  right: -10px;
  background-color: red;
  color: white;
  border-radius: 50%;
  padding: 3px 4px;
  font-size: 12px;
  }

</style>
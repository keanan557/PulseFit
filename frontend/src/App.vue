<template>
  <header class="navbar" :class="{ 'mobile-nav-open': isMobileNavOpen }">
    <div class="logo-container">
      <img src="@/assets/Screenshot_2025-02-13_144904-removebg-preview.png" alt="Logo" class="logo" />
    </div>

    <button class="hamburger" @click="toggleMobileNav">
      <div class="bar"></div>
      <div class="bar"></div>
      <div class="bar"></div>
    </button>

    <nav class="nav-links">
      <router-link to="/">Home</router-link>
      <router-link to="/products">Products</router-link>
      <router-link to="/cart" class="cart-link">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
          <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5M3.102 4l1.313 7h8.17l1.313-7zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4m-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2m7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2"/>
        </svg>
        <span class="cart-badge">{{ cartItemCount }}</span>
      </router-link>
      <router-link to="/ContactUs">Get in touch</router-link>
      <router-link to="/Login">Login</router-link>
      <router-link to="/MyProfile">My Profile</router-link>
      <router-link to="/AdminLogin">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
          <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10s-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664z"/>
        </svg>
      </router-link>

      <span v-if="isLoggedIn && showWelcomeMessage">Welcome, {{ userName }}!</span>
      <button v-if="isLoggedIn" @click="logout" class="logout-btn">Logout</button>
    </nav>
  </header>
  <AdminNavbar v-if="isAdminPage" />
  <RouterView />
</template>

<script>
import AdminNavbar from './components/AdminNavbar.vue';
import { mapGetters } from 'vuex';

export default {
  components: { AdminNavbar },
  data() {
    return {
      showWelcomeMessage: true,
      isMobileNavOpen: false,
    };
  },
  computed: {
    isAdminPage() {
      const path = this.$route.path;
      return path.startsWith("/AdminHome") ||
        path.startsWith("/AddNewProducts") ||
        path.startsWith("/AdminEditProducts") ||
        path.startsWith("/OrdersPage") ||
        path.startsWith("/AddNewAdmin") ||
        path.startsWith("/Mail");
    },
    ...mapGetters(['cartItemCount']),
    isLoggedIn() {
      return !!this.$store.state.user;
    },
    userName() {
      return this.$store.state.user ? this.$store.state.user.name : '';
    },
  },
  methods: {
    logout() {
      localStorage.removeItem("authToken");
      localStorage.removeItem("userName");
      this.$store.commit("setUser", null);
      this.$router.push("/login");
    },
    toggleMobileNav() {
      this.isMobileNavOpen = !this.isMobileNavOpen;
    },
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

.navbar .logo-container {
  display: flex;
  justify-content: flex-start;
  align-items: center;
}

.navbar .logo {
  width: 100px;
  height: auto;
}

.navbar .nav-links {
  display: flex;
  justify-content: flex-end;
  align-items: center;
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

.logout-btn {
  background-color: #f81313;  /* Red color */
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 5px;
  cursor: pointer;
  font-weight: bold;
  transition: background 0.3s;
  margin-bottom: 20px;  /* Space from bottom */
}

.logout-btn:hover {
  background-color: #7c1616;  /* Darker red on hover */
}

.navbar {
  background-color: #000;
  color: white;
  padding: 15px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: relative;
}

.navbar .logo-container {
  display: flex;
  justify-content: flex-start;
  align-items: center;
}

.navbar .logo {
  width: 80px;
  height: auto;
}

.navbar .nav-links {
  display: flex;
  justify-content: flex-end;
  align-items: center;
}

.navbar .nav-links a {
  color: white;
  text-decoration: none;
  font-weight: bold;
  margin: 0 15px;
}

.navbar .nav-links a:hover {
  color: #E60000;
}

.cart-link {
  position: relative;
}

.cart-badge {
  position: absolute;
  top: -5px;
  right: -10px;
  background-color: red;
  color: white;
  border-radius: 50%;
  padding: 3px 4px;
  font-size: 12px;
}

.logout-btn {
  background-color: #f81313;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 5px;
  cursor: pointer;
  font-weight: bold;
  transition: background 0.3s;
  margin-bottom: 20px;
}

.logout-btn:hover {
  background-color: #7c1616;
}

.hamburger {
  display: none;
  flex-direction: column;
  justify-content: space-around;
  width: 30px;
  height: 25px;
  background: transparent;
  border: none;
  cursor: pointer;
  padding: 0;
}

.hamburger .bar {
  width: 100%;
  height: 3px;
  background-color: white;
  border-radius: 10px;
}

/* Responsive Styles */
@media (max-width: 768px) {
  .navbar .nav-links {
    display: none;
    flex-direction: column;
    width: 100%;
    position: absolute;
    top: 60px;
    left: 0;
    background-color: #000;
    align-items: flex-start;
    padding: 10px;
    z-index: 100; /* Ensure it's on top of other elements */
  }

  .navbar.mobile-nav-open .nav-links {
    display: flex;
  }

  .navbar .nav-links a,
  .navbar .logout-btn {
    margin: 10px 0;
    display: block;
    width: 100%;
    text-align: left;
    padding: 8px 15px;
    box-sizing: border-box;
  }

  .hamburger {
    display: flex;
  }

  .navbar .nav-links {
    justify-content: flex-start;
  }

  .navbar .cart-link {
    margin-left: 10px;
  }
}

@media (max-width: 576px) {
  .navbar .logo {
    width: 70px;
  }

  .navbar {
    padding: 10px;
  }
}

@media (max-width: 480px) {
  .navbar .logo {
    width: 60px;
  }
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .navbar .nav-links {
    justify-content: center;
    flex: 1 1 100%;
  }

  .navbar .nav-links a {
    margin: 5px 8px;
    font-size: 0.9rem;
  }

  .navbar .logo {
    width: 70px;
  }
}

@media (max-width: 576px) {
  .navbar .logo {
    width: 60px;
  }

  .navbar .nav-links a {
    margin: 5px 5px;
    font-size: 0.8rem;
  }

  .logout-btn {
    padding: 6px 12px;
    font-size: 0.8rem;
  }
}

@media (max-width: 480px) {
  .navbar {
    padding: 10px;
  }
}
</style>

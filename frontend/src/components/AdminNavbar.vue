<template>
  <nav class="admin-nav">
    <div :class="{'nav-menu': true, 'open': isMenuOpen}">
      <div class="nav-links">
        <router-link to="/AdminHome" class="nav-link">📊 Dashboard</router-link>
        <router-link to="/AddNewProducts" class="nav-link">➕ Add New Products</router-link>
        <router-link to="/AdminEditProducts" class="nav-link">✏️ Edit Products</router-link>
        <!-- <router-link to="/OrdersPage" class="nav-link">📦 Orders</router-link> -->
        <router-link to="/AddNewAdmin" class="nav-link">👤 Add Admin</router-link>
        <!-- <router-link to="/AddNewAdmin" class="nav-link">👥 Customers</router-link> -->
        <!-- <router-link to="/AddNewAdmin" class="nav-link">⭐ Reviews</router-link> -->
        <router-link to="/Mail" class="nav-link"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
  <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z"/>
</svg>       Mail</router-link>

      </div>

      <button @click.prevent="logout" class="logout-btn">Log Out</button>
    </div>

    <button @click="toggleMenu" class="menu-toggle-btn" :class="{'open': isMenuOpen}">
      <div class="hamburger-icon"></div>
      <div class="hamburger-icon"></div>
      <div class="hamburger-icon"></div>
    </button>
  </nav>
</template>

<script>
export default {
  data() {
    return {
      isMenuOpen: false,
    };
  },
  methods: {
    toggleMenu() {
      this.isMenuOpen = !this.isMenuOpen;
    },
    logout() {
      // localStorage.removeItem("authToken");
      this.$store.dispatch('logout')

      this.$router.push("/AdminLogin");
    }
  }
};
</script>

<style scoped>
/* Style for the entire navigation bar */
.admin-nav {
  position: relative;
  z-index: 1000;
}
/* Menu that pops out from the left */
.nav-menu {
  position: fixed;
  top: 0;
  left: -250px;
  width: 250px;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.7);
  color: white;
  padding: 20px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  transition: left 0.3s ease, opacity 0.3s ease;
  opacity: 0;
  visibility: hidden;
  outline: 3px solid red; /* Red outline around the menu */
}
.nav-menu.open {
  left: 0;  /* Slide in when open */
  opacity: 1; /* Make the menu visible when open */
  visibility: visible; /* Make it visible */
}
/* Container for centered navigation links */
.nav-links {
  display: flex;
  flex-direction: column;
  justify-content: flex-start; /* Align links at the top */
  margin-top: 40px;  /* Added more space from top */
}
/* Styling for each navigation link */
.nav-link {
  color: white;
  text-decoration: none;
  margin: 10px 0;
  font-weight: bold;
  transition: color 0.3s;
  outline: 2px solid red; /* Adds a red outline */
  padding: 5px; /* Adds spacing for better visibility */
  border-radius: 5px; /* Optional: Adds rounded corners */
}
.nav-link:hover {
  color: #FF0000;
  outline-color: darkred; /* Change outline color on hover */
}
/* Styling for logout button */
.logout-btn {
  background-color: #F81313;  /* Red color */
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
  background-color: #7C1616;  /* Darker red on hover */
}
/* Menu Toggle Button */
.menu-toggle-btn {
  position: absolute;
  top: 15px;  /* Move the icon closer to the top */
  left: 15px;  /* Move the icon closer to the left edge */
  background-color: transparent;
  border: red;
  padding: 0;
  cursor: pointer;
  z-index: 1010;
  display: flex;
  flex-direction: column;
  justify-content: space-between; /* Ensures spacing between lines */
  align-items: center;
  height: 24px; /* Decrease the height */
  width: 24px;  /* Decrease the width */
  transition: transform 0.3s ease;
  border-color: #FF0000;
}
/* Styling for each line of the hamburger icon */
.hamburger-icon {
  width: 24px;  /* Reduced width */
  height: 4px;  /* Reduced height */
  background-color: rgb(240, 240, 240);
  border-radius: 5px;
  transition: transform 0.3s ease, opacity 0.3s ease;
  outline: 2px solid red;
}
/* Rotate hamburger icon to form an 'X' when open */
.menu-toggle-btn.open .hamburger-icon:nth-child(1) {
  transform: translateY(7px) rotate(45deg);
}
.menu-toggle-btn.open .hamburger-icon:nth-child(2) {
  opacity: 0;  /* Hide the middle line */
}
.menu-toggle-btn.open .hamburger-icon:nth-child(3) {
  transform: translateY(-7px) rotate(-45deg);
}
</style>

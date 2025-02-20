<template>
    <nav class="admin-nav">
        <div class="nav-links">
        <router-link class="nav-link" to="/OrdersPage">Orders</router-link>   |
        <router-link class="nav-link" to="/AddNewAdmin">Edit Admin</router-link>   |
        <router-link class="nav-link" to="/AddNewProducts">Edit Content</router-link>  |
        <router-link class="nav-link" to="/AdminEditProducts">AdminEditProducts</router-link>   |
        <button @click.prevent="logout" class="logout-btn"> Log Out</button>
   </div>
   </nav>
</template>

<script>
    export default {
        methods:{
            logout(){
                        localStorage.removeItem("authToken"); // ✅ Remove token
                        this.$router.push("/AdminLogin"); // ✅ Redirect to login
                    }
        }
        
    }
</script>

<style>
.admin-nav{
    background-color: #000;
}
     /* Styling for each navigation link */
  .nav-link {
    color: white;
    text-decoration: none;
    margin: 10px 0;
    font-weight: bold;
    transition: color 0.3s;
  }
  .nav-link:hover {
    color: #FF0000; /* Change color on hover */
  }
  /* Styling for logout button */
  .logout-btn {
    background-color: #FF4D4D;  /* Red color */
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
</style>
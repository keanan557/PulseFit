<template>
    <h1>Admin Home</h1>

    <h2>Welcome {{ username }}</h2>
    <!-- <h2 v-else>Access Denied</h2> -->

</template>

<script>
// import {jwtDecode} from 'jwt-decode';  // ✅ Correct import

export default {
    data() {
        return {
            username: '',
            // isAdmin: false
        }
    },

    created() {
        const token = localStorage.getItem('authToken');
        console.log('Stored token:', token); // Debugging

       
  },

  
};
</script>

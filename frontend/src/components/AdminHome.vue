<template>
    <h1>Admin Home</h1>
    <h2>Welcome {{ username }}</h2>
</template>

<script>
import jwtDecode from 'jwt-decode'; 

export default {
  name: 'AdminHome',
  data() {
    return {
    //   username: ''
    }
  },
  computed:{
    username(){
        return localStorage.getItem('userName')
    }
  },
  created() {
    const token = localStorage.getItem('authToken');
    console.log('Stored token:', token); 
    if (token) {
      try {
        const decoded = jwtDecode(token);
this.username = decoded.username;

        console.log('Decoded token:', decoded);
        this.username = decoded.username; 
      } catch (error) {
        console.error('Token decoding failed:', error);
      }
    } else {
      
      this.$router.push('/AdminLogin');
    }
  }
};
    
</script>

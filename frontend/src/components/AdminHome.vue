<template>
    <h1>Admin Home</h1>

    <h2>Welcome {{ username }}</h2>

    <button @click="logout">Log out</button>
</template>

<script>
import {jwtDecode} from 'jwt-decode';  // ✅ Correct import

export default {
    data() {
        return {
            username: ''
        }
    },

    created() {
        const token = localStorage.getItem('authToken');
        console.log('Stored token:', token); // Debugging

        if (!token) {
            // If no token, redirect to login page
            this.$router.push('/AdminLogin');
        } else {
            try {
                // Decode the token to get the username
                const decoded = jwtDecode(token);  // ✅ Correct usage
                console.log('Decoded token:', decoded); // Debugging
                this.username = decoded.username;
            } catch (error) {
                console.error('Token decoding failed:', error);
                localStorage.removeItem('authToken');
                this.$router.push('/AdminLogin');
            }
        }
    },

    methods: {
        logout() {
            localStorage.removeItem('authToken');
            this.$router.push('/AdminLogin');
        }
    }
};
</script>

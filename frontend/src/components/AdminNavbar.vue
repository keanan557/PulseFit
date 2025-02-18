<template>
    <nav>
        <router-link to="">Edit Admin</router-link>   |
        <router-link to="/AddNewProducts">Edit Content</router-link>  |
        <router-link to="/AdminEditProducts">AdminEditProducts</router-link>   |
        <button @click.prevent="logout"> Log Out</button>
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
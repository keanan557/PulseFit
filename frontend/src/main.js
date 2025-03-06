import { createApp } from 'vue';
import App from './App.vue';
import router from './routes'; // Import your Vue Router
import store from './store';  // Import the Vuex store

const app = createApp(App)

// main.js
app.mixin({
    async mounted() {
        const userId = localStorage.getItem("userId");
        const token = localStorage.getItem("authToken");
        if (userId && token) {
            try {
                const response = await fetch(`http://localhost:3000/api/users/${userId}`, { // Correct endpoint
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                });
                if (response.ok) {
                    const user = await response.json();
                    this.$store.commit("setUser", user);
                } else {
                    console.error("Failed to fetch user:", response.status);
                    localStorage.removeItem("userId");
                    localStorage.removeItem("authToken");
                    this.$store.commit("setUser", null);
                }
            } catch (error) {
                console.error("Error fetching user:", error);
                localStorage.removeItem("userId");
                localStorage.removeItem("authToken");
                this.$store.commit("setUser", null);
            }
        }
    }
});

app.use(router).use(store).mount('#app');

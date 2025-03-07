// imports
import { createApp } from 'vue';
import App from './App.vue';
import router from './routes'; // Import your Vue Router
import store from './store';  // Import the Vuex store

const app = createApp(App)

// globally  add mixin method for user auth from local store
app.mixin({
    async mounted() {
        const userId = localStorage.getItem("userId");
        const token = localStorage.getItem("authToken");
        // check if userid and token exist
        if (userId && token) {
            try {
                // fetch from api
                const response = await fetch(`http://localhost:3000/api/users/${userId}`, { // Correct endpoint
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                });
                // check if successful
                if (response.ok) {
                    const user = await response.json();
                    this.$store.commit("setUser", user);
                } else {
                    // log error
                    console.error("Failed to fetch user:", response.status);
                    localStorage.removeItem("userId");
                    localStorage.removeItem("authToken");
                    this.$store.commit("setUser", null);
                }
                // catch error
            } catch (error) {
                console.error("Error fetching user:", error);
                // clear
                localStorage.removeItem("userId");
                localStorage.removeItem("authToken");
                this.$store.commit("setUser", null);
            }
        }
    }
});

// mount vue app
app.use(router).use(store).mount('#app');

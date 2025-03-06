import { createApp } from 'vue';
import App from './App.vue';
import router from './routes'; // Import your Vue Router
import store from './store';  // Import the Vuex store

const app = createApp(App)

app.mixin({
  mounted() {
      const userString = localStorage.getItem("userEmail");
      const userName = localStorage.getItem("userName");
      const userID = localStorage.getItem("userId");
      if (userString && userName && userID) {
          const user = {
              email: userString,
              name: userName,
              id: userID,
          };
          this.$store.commit("setUser", user);
      }
  }
});

  


app.use(router).use(store).mount('#app');

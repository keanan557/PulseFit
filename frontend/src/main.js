import { createApp } from 'vue';
import App from './App.vue';
import router from './routes'; // Import your Vue Router
import store from './store';  // Import the Vuex store

const app = createApp(App)

app.mixin({
  mounted(){
    const userName = localStorage.getItem("userName")
    if(userName){
      this.$store.commit("setUser", userName)
    }
  }
})


createApp(App)
  .use(router)  // Register the router
  .use(store)   // Register Vuex store
  .mount('#app');

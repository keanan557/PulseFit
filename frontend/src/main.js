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


app.use(router).use(store).mount('#app');

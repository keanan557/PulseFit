import { createApp } from 'vue';
import App from './App.vue';
import router from './routes'; // Import your Vue Router
import store from './store';  // Import the Vuex store

createApp(App)
  .use(router)  // Register the router
  .use(store)   // Register Vuex store
  .mount('#app');

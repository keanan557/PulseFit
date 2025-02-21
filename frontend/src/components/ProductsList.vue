<template>
    <div>
      <h2>Products</h2>
      <label>Search :</label><input type="search"><button>Go!</button>
      <div v-if="loading">Loading products...</div>
      <div v-else-if="products.length === 0">No products available.</div>
      <ul v-else>
        <li v-for="product in products" :key="product.id">
          <img :src="'http://localhost:3000/uploads/' + product.image" :alt="product.name" width="100" />

          <h3>{{ product.name }}</h3>
          <p>{{ product.description }}</p>
          <p>Price: R{{ product.price }}</p>
          <p>Quantity: {{ product.quantity }}</p>

          <button @click="addToCart(product)">+ cart</button>
        </li>
      </ul>
    </div>
  </template>
  
  <script>
  import { computed, onMounted, ref } from 'vue';
  import { useStore } from 'vuex';
  
  export default {
    setup() {
      const store = useStore();
      const loading = ref(true);
  
      // Compute the products from Vuex state
      const products = computed(() => store.getters['allProducts']);
  
      // Fetch products when component is mounted
      onMounted(async () => {
        await store.dispatch('fetchProducts');
        loading.value = false;
      });

      const addToCart = (product) =>{
        store.dispatch('addToCart', product)
      }
  
      return { products, loading , addToCart};
    }
  };
  </script>
  
<style>

</style>
  
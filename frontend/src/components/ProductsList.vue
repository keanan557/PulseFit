<template>
  <div>
    <h2>Products</h2>
    <div class="search-container">
      <input v-model="searchQuery" @input="filterProducts" type="text" placeholder="Search for product..." />
    </div>
    <div v-if="loading">Loading products...</div>
    <div v-else-if="filteredProducts.length === 0">No products available.</div>
    <ul v-else>
      <li v-for="product in filteredProducts" :key="product.id">
        <img :src="product.image" :alt="product.name" width="100" />
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
    const searchQuery = ref("");
    // Compute the products from Vuex state
    const products = computed(() => store.getters['allProducts']);
    // Computed property to filter products based on search query
    const filteredProducts = computed(() => {
      if (!searchQuery.value) {
        return products.value;
      }
      return products.value.filter(product =>
        product.name.toLowerCase().includes(searchQuery.value.toLowerCase())
      );
    });
    // Fetch products when component is mounted
    onMounted(async () => {
      await store.dispatch('fetchProducts');
      loading.value = false;
    });
    const addToCart = (product) => {
      store.dispatch('addToCart', product);
    };
    return { products, loading, addToCart, searchQuery, filteredProducts };
  }
};
</script>
<style>
</style>




NEW








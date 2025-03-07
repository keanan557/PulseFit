<template>
  <div class="products-container">
    <h2 v-if="!selectedProduct">Products</h2>
    <!-- Search Bar -->
    <div v-if="!selectedProduct" class="search-container">
      <input
        type="text"
        v-model="searchQuery"
        class="search-input"
        placeholder="Search products..."
      />
      <button class="search-btn" @click="performSearch">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 16 16">
          <path d="M11.742 10.742a6.5 6.5 0 1 0-1.414 1.414 6.5 6.5 0 0 0 1.414-1.414zM12 7a5 5 0 1 1-10 0 5 5 0 0 1 10 0z"/>
        </svg>
      </button>
    </div>
    <!-- Product Details View -->
<div v-if="selectedProduct" class="product-details">
      <h2>{{ selectedProduct.name }}</h2>
      <!-- <img :src="selectedProduct.image" :alt="selectedProduct.name" class="product-image" /> -->
      <!-- <p>{{ selectedProduct.description }}</p>
      <p>Price: R{{ selectedProduct.price }}</p> -->
      <div>
        <ProductDetails v-if="selectedProduct && selectedProduct.product_id"
  :productId="Number(selectedProduct.product_id)" />
      </div>
      <button @click="addToCart(selectedProduct)" class="add-to-cart-button">+ Cart</button>
      <button @click="selectedProduct = null" class="back-button">Back to Products</button>
    </div>
    <!-- Product List -->
    <div v-else-if="loading">Loading products...</div>
    <div v-else-if="filteredProducts.length === 0">No products found.</div>
    <div v-else class="product-cards-container">
      <div
        v-for="product in filteredProducts"
        :key="product.id"
        class="product-card"
        @click="viewProduct(product)"
      >
        <div class="product-content">
          <img :src="product.image" :alt="product.name" class="product-image" />
          <h3>{{ product.name }}</h3>
          <p>Price: R{{ product.price }}</p>
        </div>
        <button @click.stop="addToCart(product)" class="add-to-cart-button">+ Cart</button>
      </div>
    </div>
    <div v-if="notification" class="notification">
      {{ notification }}
    </div>
  </div>
</template>
<script>
import ProductDetails from '@/components/ProductDetails.vue'
import { computed, onMounted, ref } from 'vue';
import { useStore } from 'vuex';
export default {
  components: {
    ProductDetails
  },
  setup() {
    const store = useStore();
    const loading = ref(true);
    const searchQuery = ref("");
    const selectedProduct = ref(null);
    const notification = ref(null)
    // Compute the products from Vuex state
    const products = computed(() => store.getters['allProducts']);
    // Computed property to filter products based on search query
    const filteredProducts = computed(() => {
      if (!searchQuery.value)
        return products.value;
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
      notification.value = `${product.name} added to cart!`
      setTimeout(()=>{
        notification.value = null;
      }, 2000);
    };
    const performSearch = () => {
      console.log("Searching for:", searchQuery.value);
    };
    const viewProduct = (product) => {
  if (!product || (!product.id && !product.product_id)) {
    console.error("Invalid product data:", product);
    return;
  }
  console.log("Valid product selected:", product);
  // Ensure we're using the correct product ID field
  selectedProduct.value = {
    ...product,
    product_id: product.product_id || product.id, // Normalize the ID
  };
};
    return { products, loading, addToCart, searchQuery, filteredProducts, performSearch, selectedProduct, viewProduct,notification  };
  }
};
</script>
<style scoped>
/* Notification Styles */
.notification {
  background-color: red;
  color: white;
  text-align: center;
  padding: 10px;
  position: fixed;
  bottom: 20px;
  left: 50%;
  transform: translateX(-50%);
  border-radius: 5px;
  z-index: 1000;
}
/* General Styles */
.products-container {
  background-color: #333;
  color: #fff;
  padding: 20px;
  border-radius: 0px;
  display: flex;
  flex-direction: column;
  align-items: center;
}
/* Search */
.search-container {
  display: flex;
  align-items: center;
  justify-content: center;
  max-width: 400px;
  margin: 20px auto;
  padding: 5px;
  background-color: #F9F9F9;
  border-radius: 25px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
.search-input {
  flex-grow: 1;
  padding: 10px;
  border: none;
  border-radius: 25px;
  font-size: 16px;
  outline: none;
}
.search-btn {
  background-color: transparent;
  border: none;
  cursor: pointer;
  padding: 8px;
  margin-left: 10px;
}
.search-btn svg {
  fill: #333;
  width: 20px;
  height: 20px;
  transition: fill 0.3s ease;
}
.search-btn:hover svg {
  fill: #E60000;
}
/* Product Grid */
.product-cards-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 20px;
  width: 100%;
  padding: 20px;
}
.product-card {
  background-color: rgba(0, 0, 0, 0.7);
  padding: 20px;
  border-radius: 8px;
  text-align: center;
  transition: transform 0.3s ease-in-out;
  cursor: pointer;
}
.product-card:hover {
  transform: scale(1.05);
}
.product-image {
  width: 100%;
  height: 200px;
  object-fit: cover;
  margin-bottom: 10px;
  border-radius: 8px;
}
/* Buttons */
.add-to-cart-button {
  background-color: red;
  color: #fff;
  border: none;
  padding: 10px 20px;
  cursor: pointer;
  font-size: 1rem;
  border-radius: 4px;
  margin-top: 10px;
}
.add-to-cart-button:hover {
  background-color: #c00;
}
.back-button {
  background-color: gray;
  color: #fff;
  border: none;
  padding: 10px 20px;
  cursor: pointer;
  font-size: 1rem;
  border-radius: 4px;
  margin-top: 10px;
}
.back-button:hover {
  background-color: darkgray;
}
/* Responsive Layout */
@media (max-width: 768px) {
  /* Adjust the grid layout */
  .product-cards-container {
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));  /* Make cards smaller on mobile */
  }
  /* Adjust the search bar */
  .search-container {
    max-width: 100%;
    margin: 10px auto;
  }
  .search-input {
    font-size: 14px; /* Smaller text for mobile */
  }
  .search-btn svg {
    width: 18px;  /* Smaller icon for mobile */
    height: 18px;
  }
  /* Reduce button sizes */
  .add-to-cart-button,
  .back-button {
    font-size: 0.9rem;
    padding: 8px 16px;
  }
  /* Ensure text fits properly */
  .product-image {
    height: 150px; /* Reduce image height on mobile */
  }
  .product-card {
    padding: 15px; /* Reduce card padding */
  }
}
</style>
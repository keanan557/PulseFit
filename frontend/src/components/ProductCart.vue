<template>
    <div>
      <h1>Cart</h1>
  
      <div v-if="cartItems.length === 0">Your cart is empty.</div>
  
      <div v-else>
        <ul>
          <li v-for="item in cartItems" :key="item.id">
            <img :src="'http://localhost:3000/uploads/' + item.image" :alt="item.name" width="100" />
            
            <h3>{{ item.name }}</h3>
            <p>Price: ${{ item.price }}</p>
            
            <!-- Quantity input -->
            <p>
              Quantity: 
              <button @click="updateQuantity(item, -1)" :disabled="item.quantity <= 1">-</button>
              {{ item.quantity }}
              <button @click="updateQuantity(item, 1)">+</button>
            </p>
            
            <p>Total: R{{ (item.price * item.quantity).toFixed(2) }}</p>
            
            <!-- Remove button -->
            <button @click="removeFromCart(item)">Remove</button>
          </li>
        </ul>
        
        <div>
          <h3>Total Price: ${{ totalPrice.toFixed(2) }}</h3>
          <button @click="checkout">Proceed to Checkout</button>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import { computed } from 'vue';
  import { useStore } from 'vuex';
  
  export default {
    setup() {
      const store = useStore();
  
      // Get cart items from Vuex state
      const cartItems = computed(() => store.getters['cartItems']);
  
      // Calculate total price
      const totalPrice = computed(() => {
        return cartItems.value.reduce((total, item) => total + (item.price * item.quantity), 0);
      });
  
      // Update quantity in the cart
      const updateQuantity = (item, change) => {
        if (item.quantity + change >= 1) {
          store.dispatch('updateCartQuantity', { id: item.id, change });
        }
      };
  
      // Remove product from the cart
      const removeFromCart = (item) => {
        store.dispatch('removeFromCart', item.id);
      };
  
      // Proceed to checkout (you can implement your own checkout flow)
      const checkout = () => {
        alert('Proceeding to checkout...');
      };
  
      return { cartItems, totalPrice, updateQuantity, removeFromCart, checkout };
    }
  };
  </script>
  
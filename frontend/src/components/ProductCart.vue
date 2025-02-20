<template>
  <div class="cart-checkout-container">
    <h1>Shopping Cart</h1>

    <div v-if="cartItems.length === 0">Your cart is empty.</div>

    <div v-else>
      <ul class="cart-items">
        <li v-for="item in cartItems" :key="item.id" class="cart-item">
          <img :src="'http://localhost:3000/uploads/' + item.image" :alt="item.name" width="100" />

          <div class="item-details">
            <h3>{{ item.name }}</h3>
            <p>Price: ${{ item.price }}</p>
            
            <p>
              Quantity:
              <button @click="updateQuantity(item, -1)" :disabled="item.quantity <= 1">-</button>
              {{ item.quantity }}
              <button @click="updateQuantity(item, 1)">+</button>
            </p>

            <p>Total: R{{ (item.price * item.quantity).toFixed(2) }}</p>
            <button class="remove-button" @click="removeFromCart(item)">Remove</button>
          </div>
        </li>
      </ul>

      <div class="cart-summary">
        <h3>Total Price: ${{ totalPrice.toFixed(2) }}</h3>
        <button @click="toggleCheckout" class="checkout-toggle-button">
          {{ showCheckout ? "Back to Cart" : "Proceed to Checkout" }}
        </button>
      </div>
    </div>

    <!-- Checkout Section -->
    <div v-if="showCheckout" class="checkout-container">
      <h1 class="checkout-title">Checkout</h1>

      <!-- Shipping Address -->
      <section class="shipping-address">
        <h3>Shipping Address</h3>
        <form @submit.prevent="submitShippingAddress">
          <div class="form-group">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" v-model="shippingAddress.fullName" required />
          </div>
          <div class="form-group">
            <label for="address">Address</label>
            <input type="text" id="address" v-model="shippingAddress.address" required />
          </div>
          <div class="form-group">
            <label for="city">City</label>
            <input type="text" id="city" v-model="shippingAddress.city" required />
          </div>
          <div class="form-group">
            <label for="zipCode">Zip Code</label>
            <input type="text" id="zipCode" v-model="shippingAddress.zipCode" required />
          </div>
          <div class="form-group">
            <label for="country">Country</label>
            <input type="text" id="country" v-model="shippingAddress.country" required />
          </div>
          <button type="submit" class="submit-button">Save Shipping Address</button>
        </form>
      </section>

      <!-- Payment Methods -->
      <section class="payment-methods">
        <h3>Payment Methods</h3>
        <div class="payment-options">
          <label>
            <input type="radio" value="Credit Card" v-model="paymentMethod" /> Credit Card
          </label>
          <label>
            <input type="radio" value="PayPal" v-model="paymentMethod" /> PayPal
          </label>
          <label>
            <input type="radio" value="Bank Transfer" v-model="paymentMethod" /> Bank Transfer
          </label>
        </div>

        <!-- Credit Card Details -->
        <div v-if="paymentMethod === 'Credit Card'" class="credit-card-details">
          <div class="form-group">
            <label for="cardNumber">Card Number</label>
            <input type="text" id="cardNumber" v-model="creditCardDetails.cardNumber" required />
          </div>
          <div class="form-group">
            <label for="expiryDate">Expiry Date</label>
            <input type="month" id="expiryDate" v-model="creditCardDetails.expiryDate" required />
          </div>
          <div class="form-group">
            <label for="cvv">CVV</label>
            <input type="text" id="cvv" v-model="creditCardDetails.cvv" required />
          </div>
        </div>

        <button @click="submitPayment" class="submit-button">Proceed to Payment</button>
      </section>
    </div>
  </div>
</template>

<script>
import { ref, computed } from 'vue';
import { useStore } from 'vuex';

export default {
  setup() {
    const store = useStore();
    const showCheckout = ref(false);

    // Cart Data
    const cartItems = computed(() => store.getters['cartItems']);
    const totalPrice = computed(() => cartItems.value.reduce((total, item) => total + (item.price * item.quantity), 0));

    // Shipping Address Data
    const shippingAddress = ref({
      fullName: '',
      address: '',
      city: '',
      zipCode: '',
      country: ''
    });

    // Payment Data
    const paymentMethod = ref('');
    const creditCardDetails = ref({
      cardNumber: '',
      expiryDate: '',
      cvv: ''
    });

    // Functions
    const toggleCheckout = () => showCheckout.value = !showCheckout.value;

    const updateQuantity = (item, change) => {
      if (item.quantity + change >= 1) {
        store.dispatch('updateCartQuantity', { id: item.id, change });
      }
    };

    const removeFromCart = (item) => {
      store.dispatch('removeFromCart', item.id);
    };

    const submitShippingAddress = () => {
      if (Object.values(shippingAddress.value).some(val => !val)) {
        alert('Please fill out the shipping address.');
      } else {
        alert('Shipping Address Saved!');
      }
    };

    const submitPayment = () => {
      if (!paymentMethod.value) {
        alert('Please select a payment method!');
        return;
      }
      if (paymentMethod.value === 'Credit Card' && (!creditCardDetails.value.cardNumber || !creditCardDetails.value.expiryDate || !creditCardDetails.value.cvv)) {
        alert('Please fill out your credit card details.');
        return;
      }
      alert('Payment Processed Successfully!');
    };

    return {
      cartItems,
      totalPrice,
      showCheckout,
      shippingAddress,
      paymentMethod,
      creditCardDetails,
      toggleCheckout,
      updateQuantity,
      removeFromCart,
      submitShippingAddress,
      submitPayment
    };
  }
};
</script>

<style scoped>
.cart-checkout-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  background-color: #F5F5F5;
  border-radius: 8px;
}

.cart-items {
  list-style: none;
  padding: 0;
}

.cart-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 15px;
  background: white;
  padding: 10px;
  border-radius: 5px;
}

.item-details {
  flex: 1;
  padding-left: 15px;
}

.remove-button {
  background: red;
  color: white;
  border: none;
  padding: 5px 10px;
  cursor: pointer;
}

.cart-summary {
  text-align: center;
  margin-top: 20px;
}

.checkout-toggle-button,
.submit-button {
  background: #FF6347;
  color: white;
  border: none;
  padding: 10px 20px;
  cursor: pointer;
  width: 100%;
  border-radius: 4px;
}

.checkout-container {
  margin-top: 30px;
  background-color: #fff;
  padding: 20px;
  border-radius: 8px;
}

h3 {
  color: #FF6347;
}
</style>

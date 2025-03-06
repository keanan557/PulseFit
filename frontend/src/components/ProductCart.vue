<template>
  <div class="cart-checkout-container">
    <h1 class="sc">Shopping Cart</h1>

    <div v-if="cartItems.length === 0" class="empty-cart">
      Your cart is empty.
        <br>
        <br>
        <br>
    <button class="gs">
      <router-link to="/products" style="text-decoration: none;">Go shopping</router-link>  
    </button>
  </div> 

    <div v-else>
      <ul class="cart-items">
        <li v-for="item in cartItems" :key="item.product_id" class="cart-item">
          <img :src="item.image" :alt="item.name" width="100" />
          <div class="item-details">
            <h3>{{ item?.name }}</h3>
            <p>Price: R{{ item.price }}</p>
            <p>
              Quantity:
              <button @click="updateQuantity(item, -1)" :disabled="item.quantity <= 1" class="srb">-</button>
              {{ item.quantity }}
              <button @click="updateQuantity(item, 1)" class="srb">+</button>
            </p>
            <p>Total: R{{ (item.price * item.quantity).toFixed(2) }}</p>
            <button class="remove-button" @click="removeFromCart(item.product_id)">Remove</button>
          </div>
        </li>
      </ul>
      <div class="cart-summary">
        <h3>Total Price: R{{ totalPrice.toFixed(2) }}</h3>
        <button @click="proceedToCheckout" class="checkout-toggle-button">
          {{ showCheckout ? "Back to Cart" : "Proceed to Checkout" }}
        </button>
        <button @click="clearCart" class="clear-cart-button">Clear Cart</button>
      </div>
    </div>


    <!-- Checkout Section -->
    <div v-if="showCheckout" class="checkout-container">
      <h1 class="checkout-title">Checkout</h1>

      <!-- user -->
       <div class="user-info">
        <h3>User</h3>
        <p>Name:{{ user?.name }}</p>
       </div>

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
import { useRouter } from 'vue-router';
/*eslint-disable*/
export default {
  setup() {
    const store = useStore();
    const showCheckout = ref(false);
    const router = useRouter()

    // get logged in user from vuex
    const user = computed(()=> store.getters.user)
    const userId = computed(()=> user.value?.user_id || localStorage.getItem("userId"))
    const token = computed(()=> localStorage.getItem("authToken") || store.state.token)

    console.log("User from store:", store.state.user);
    console.log("Auth Token:", token.value);
    

    // redirect login if not login
    const proceedToCheckout = () =>{
      console.log("Current user", user.value);
      console.log(user);
      // store.commit('setUser','user')
      
      if(!user.value || !user.value.name){
        alert("You must be logged in to proceed")
        router.push("/login")
      }else{
        showCheckout.value = true
      }
    }

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
        store.dispatch('updateCartQuantity', { id: item.product_id, change });
      }
    };

    const removeFromCart = (id) => {
      store.dispatch('removeFromCart', id);
    };

    const submitShippingAddress = () => {
      if (Object.values(shippingAddress.value).some(val => !val)) {
        alert('Please fill out the shipping address.');
      } else {
        alert('Shipping Address Saved!');
      }
    };

    const submitPayment = async () => {
  if (!paymentMethod.value) {
    alert('Please select a payment method!');
    return;
  }
  if (
    paymentMethod.value === 'Credit Card' &&
    (!creditCardDetails.value.cardNumber ||
      !creditCardDetails.value.expiryDate ||
      !creditCardDetails.value.cvv)
  ) {
    alert('Please fill out your credit card details.');
    return;
  }

  if (!token.value) {
    alert('Authentication error! Please log in again');
    return;
  }

  const orderDate = new Date().toISOString().slice(0, 19).replace('T', ' ');

  const orderData = {
    user_id: userId.value,
    items: JSON.stringify(cartItems.value), // Send the entire cart as a JSON string
    order_date: orderDate,
    shipping_address: JSON.stringify(shippingAddress.value),
    payment_method: paymentMethod.value,
    total_price: totalPrice.value.toFixed(2), // Total price for the entire order
  };

  console.log('Vuex User:', store.getters.user);
  console.log('Local Storage User ID:', localStorage.getItem('userId'));
  console.log('User ID:', userId.value);
  // console.log('Token:', token.value);

  try {
    const response = await fetch('http://localhost:3000/api/orders', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token.value}`,
      },
      body: JSON.stringify(orderData),
    });

    if (!response.ok) {
      throw new Error('Failed to place order');
    }

    alert('Order placed successfully!');
    store.commit('clearCart');
    localStorage.removeItem('cart')
    showCheckout.value = false

  } catch (error) {
    console.error('Error submitting order:', error);
    alert('Error placing order. Please try again.');
  }
};

// clear cart
const clearCart = () =>{
  store.commit('clearCart')
  localStorage.removeItem('cart')
  showCheckout.value = false
}


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
      submitPayment,
      proceedToCheckout,
      user,
      token,
      clearCart
    };
  }
};
</script>
<style scoped>
.empty-cart{
  COLOR: red;
  font-size: large;
  text-align: center;
}
.gs {
  background-color: #202022;
  color: #fff;
  border: none;
  padding: 10px 20px;
  cursor: pointer;
  font-size: 1rem;
  border-radius: 4px;
  margin-top: 10px;
}

.link-button {
  color: white;
  text-decoration: none;
}

.gs:hover {
  background-color: #0f0d0d; 
}

.sc{
  color: whitesmoke;
}

.checkout-title{
  color: black;
}

.cart-checkout-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  background-color: #161616;
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
  background: rgb(253, 246, 246);
  padding: 10px;
  border-radius: 5px;
}

.item-details {
  flex: 1;
  padding-left: 15px;
}

.srb{
  background: red;
  color: white;
  border: none;
  border-radius: 4px;
  padding: 5px 7px;
  cursor: pointer;
}

.remove-button {
  background: red;
  color: white;
  border: none;
  padding: 5px 10px;
  cursor: pointer;
  border-radius: 4PX;
}

.cart-summary {
  text-align: center;
  margin-top: 20px;
}

.checkout-toggle-button,
.submit-button {
  background: red;
  color: white;
  border: none;
  /* padding: 10px 20px; */
  cursor: pointer;
  width: 100%;
  border-radius: 30px;
  height: 30px;
}

.checkout-container {
  margin-top: 30px;
  background-color: #fff;
  padding: 20px;
  border-radius: 8px;
}

h3 {
  color: red;
}

.clear-cart-button{
  background-color: red;
  color:white;
  border-radius: 30px;
  width: 100%;
  margin-top: 10px;
  height: 30px;
  cursor: pointer;
}
</style>

<template>
  <div class="home-page">
    <!-- Hero Section with Video Background -->
    <section class="hero-banner">
      <video class="hero-video" autoplay muted loop>
        <source :src="require('@/assets/video.mp4')" type="video/mp4" />
        Your browser does not support the video tag.
      </video>

      <div class="hero-content">
        <h1>Elevate Your Fitness</h1>
        <p>Shop the best gym equipment and gear!</p><br><br><br><h3></h3><br><br><br><br><br><br><br><br><br><br><br>
        <button class="shop-now-btn">
          <a href="#categories" style="color: white; text-decoration: none;">Shop Now</a>
        </button>
      </div>
    </section>

    <!-- Categories Section -->
    <section class="equipment-categories" id="categories">
      <h2>Browse Our Equipment</h2>
      <div class="category-grid">
        <div class="category-card" v-for="category in categories" :key="category.id">
          <img :src="category.image" :alt="category.name" class="category-image" />
          <h3>{{ category.name }}</h3>
          <p>{{ category.description }}</p>
        </div>
      </div>
      
      <!-- New Button to Navigate to Products Page -->
      <div class="view-products-button">
        <button class="shop-now-btn">
          <a id="vap-btn" href="#products" style="color: white; text-decoration: none;"><router-link class="vp" to="/products">View All Products</router-link></a>
        </button>
      </div>
    </section>

    <!-- bmi calculator -->
     <h1>Check your BMI!</h1>
    <div>
      <label>Enter Height in cm: </label>
      <input type="number" v-model="height">
      <br>
      <label>Enter Weight in kg: </label>
      <input type="number" v-model="weight"><br>
      <button @click="calculateBMI">Calculate BMI</button>

      <p v-if="bmi">Your BMI: {{ bmi }}</p>
    </div>

    <!-- Featured Products Section -->
    <section class="featured-products" id="products">
      <h2 id="next">Featured Gym Equipment</h2>
      <div class="product-grid">
        <div class="product-card" v-for="product in products" :key="product.id">
          <img :src="product.image" :alt="product.name" class="product-image" />
          <h3>{{ product.name }}</h3>
          <p class="product-description">{{ product.description }}</p>
          <span class="product-price">R{{ product.price.toFixed(2) }}</span>
        </div>
      </div>
    </section>

    <!-- Footer Section -->
    <footer>
      <p>&copy; 2025 PulseFit, All Rights Reserved</p>
    </footer>
  </div>
</template>

<script>
import {ref} from 'vue'

export default {
  setup(){
    const height = ref(0);
    const weight = ref(0);
    const bmi = ref(null);

    const calculateBMI = () => {
      if (height.value > 0 && weight.value > 0) {
        const heightInMeters = height.value / 100;
        const calculatedBMI = weight.value / (heightInMeters * heightInMeters);
        bmi.value = calculatedBMI.toFixed(2); // Round to 2 decimal places
      } else {
        alert('Please enter valid height and weight.');
        bmi.value = null; // Reset BMI if input is invalid
      }
  }

  return {
      height,
      weight,
      bmi,
      calculateBMI,
    };
},
  data() {
    return {
      categories: [
        {
          id: 1,
          name: "Strength Training",
          description: "Power up your muscles with weights, dumbbells, and more.",
          image: 'https://images.pexels.com/photos/1229356/pexels-photo-1229356.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        },
        {
          id: 2,
          name: "Cardio Equipment",
          description: "Get your heart pumping with treadmills, ellipticals, and bikes.",
          image: "https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1500w,f_auto,q_auto:best/rockcms/2021-12/211208-working-out-stock-mn-1310-55e1c7.jpg",
        },
        {
          id: 3,
          name: "Yoga & Flexibility",
          description: "Perfect for yoga mats, resistance bands, and foam rollers.",
          image: "https://www.health.com/thmb/BGOkxQ9O4pcdpbmKbm9sw238kuc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-826166326-096fa46c7d6449c8ade5ef359e4de50b.jpg",
        },
      ],
      products: [
        {
          id: 1,
          name: "Adjustable Dumbbell Set",
          description: "An adjustable dumbbell set that lets you change the weights with ease for versatile strength training.",
          price: 2749.99,
          image: "https://m.media-amazon.com/images/I/61jau6tusOL._AC_SL1500_.jpg",
        },
        {
          id: 2,
          name: "Treadmill",
          description: "A durable treadmill with various workout programs and adjustable speeds.",
          price: 6999.99,
          image: "https://retail.johnsonfitness.co.za/wp-content/uploads/2024/08/horizon_t202_se_01_new.jpg",
        },
        {
          id: 3,
          name: "Yoga Mat",
          description: "Non-slip yoga mat perfect for your home practice, made with eco-friendly materials.",
          price: 299.99,
          image: "https://media.takealot.com/covers_images/2532c5a2098447df911314e58484a55b/s-pdpxl.file",
        },
        {
          id: 4,
          name: "Kettlebell Set",
          description: "A set of cast iron kettlebells ideal for strength training, conditioning, and endurance.",
          price: 449.99,
          image: "https://resources.fitshop.com/bilder/taurus/hanteln/db2184/taurus-studio-kettlebell-pro-01_600.jpg",
        },
      ],
    };
  },
  methods: {
    goToCategory(category) {
      console.log(`Navigating to ${category.name}`);
    },
    addToCart(product) {
      console.log(`Product added to cart: ${product.name}`);
    },
  },
};
</script>

<style scoped>
/* Home Page Global Styles */
.home-page {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
}
.vp{
  text-decoration: none;
  color: #E60000;
}
.vap-btn{
  text-decoration-color: #fff;
}
/* Hero Section Styling */
.hero-banner {
  position: relative;
  width: 100%;
  height: 100vh;
  overflow: hidden;
}

.hero-video {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  z-index: -1;
}

.hero-content {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  text-align: center;
  color: white;
  z-index: 1;
}

.hero-content h1 {
  font-size: 3rem;
  margin-bottom: 15px;
}

.hero-content p {
  font-size: 1.5rem;
  margin-bottom: 20px;
}

.shop-now-btn {
  padding: 15px 30px;
  background-color: #000;
  color: white;
  border: none;
  font-size: 1.2rem;
  cursor: pointer;
  border-radius: 5px;
}

.shop-now-btn:hover {
  background-color: #333;
}

/* Categories Section Styling */
.equipment-categories {
  padding: 40px 20px;
  text-align: center;
}

.equipment-categories h2 {
  font-size: 2.5rem;
  color: #000;
  margin-bottom: 30px;
}

.category-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 30px;
}

.category-card {
  background-color: #fff;
  border: 1px solid #ddd;
  border-radius: 10px;
  padding: 20px;
  text-align: center;
  box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease-in-out;
}

.category-card:hover {
  transform: scale(1.05);
}

.category-image {
  width: 100%;
  height: 200px;
  object-fit: cover;
  border-radius: 10px;
  margin-bottom: 15px;
}

.category-card h3 {
  font-size: 1.5rem;
  color: #000;
  margin-bottom: 10px;
}

.category-card p {
  font-size: 1rem;
  color: #555;
  margin-bottom: 15px;
}

/* Button Styling for View All Products */
.view-products-button {
  margin-top: 30px;
}

.view-products-button .shop-now-btn {
  padding: 15px 30px;
  background-color: #ffffff;
  color: white;
  border: none;
  font-size: 1.2rem;
  cursor: pointer;
  border-radius: 5px;
  
}

.view-products-button .shop-now-btn:hover {
  background-color: #ffffff;
}

/* Featured Products Section Styling */
.featured-products {
  padding: 40px 20px;
  text-align: center;
}

.featured-products h2 {
  font-size: 2.5rem;
  color: #000;
  margin-bottom: 30px;
}

.product-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 30px;
}

.product-card {
  background-color: #fff;
  border: 1px solid #ddd;
  border-radius: 10px;
  padding: 20px;
  text-align: center;
  box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
}

.product-image {
  width: 100%;
  height: 250px;
  object-fit: cover;
  border-radius: 10px;
  margin-bottom: 15px;
}

.product-price {
  font-size: 1.4rem;
  font-weight: bold;
  color: #E60000; /* Red */
}

.product-card button {
  padding: 10px 20px;
  background-color: #E60000; /* Red button */
  color: rgb(255, 255, 255);
  border: none;
  font-weight: bold;
  cursor: pointer;
  border-radius: 5px;
  transition: background-color 0.3s ease-in-out;
}

.product-card button:hover {
  background-color: #B30000; /* Darker red on hover */
}

/* Footer Styling */
footer {
  background-color: #222;
  color: white;
  padding: 30px 20px;
  text-align: center;
}

footer p {
  font-size: 1rem;
}

footer a {
  color: white;
  text-decoration: none;
}

footer a:hover {
  color: #E60000; /* Red on hover */
}
</style>

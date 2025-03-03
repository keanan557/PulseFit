<template>
    <div class="home-page">
    </div>
      <div>
      <section class="featured-products">
        <h2 id="next">Featured Gym Equipment</h2>
        <div class="product-grid">
          <div class="product-card" v-for="product in products" :key="product.id">
            <img :src="product.image" :alt="product.name" class="product-image" />
            <h3>{{ product.name }}</h3>
            <p class="product-description">{{ product.description }}</p>
            <span class="product-price">R{{ product.price.toFixed(2) }}</span>
            <button @click="addToCart(product)">Add to Cart</button>
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
  export default {
    data() {
      return {
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
          {
            id: 5,
            name: "Resistance Bands Set",
            description: "A set of 5 resistance bands that help you build strength and improve flexibility.",
            price: 239.99,
            image: "https://m.media-amazon.com/images/I/71SDZVqu3+L._AC_SX679_.jpg",
          },
          {
            id: 6,
            name: "Pull-Up Bar",
            description: "A sturdy pull-up bar that fits most door frames, ideal for at-home upper body exercises.",
            price: 499.99,
            image: "https://i5-images.massmart.co.za/asr/d9174643-3ec7-4a33-9310-def894622489.52c8c8b46b0dbb7b9983f5bd01d3ff5a.jpeg?odnHeight=106&odnWidth=116&odnBg=FFFFFF",
          },
          {
            id: 7,
            name: "Exercise Ball",
            description: "A durable exercise ball, great for core workouts, flexibility, and balance.",
            price: 349.99,
            image: "https://www.algeos.com/media/catalog/product/cache/d2b2e781a4c16536e6029c3f8ce0aff7/i/m/img_0037.jpeg",
          },
          {
            id: 8,
            name: "Jump Rope",
            description: "High-quality jump rope for cardio, endurance training, and improving coordination.",
            price: 99.99,
            image: "https://promosport.co.za/cdn/shop/products/workout-skipping-rope-promosport2.jpg?v=1673522587&width=400",
          },
          {
            id: 9,
            name: "Ab Roller Wheel",
            description: "A simple but effective tool for strengthening your core and improving stability.",
            price: 449.99,
            image: "https://progymsolutions.co.za/wp-content/uploads/2024/09/AB-WHEEL-.png",
          },
          // Add more products as needed
        ],
      };
    },
    methods: {
      addToCart(product) {
        console.log(`Product added to cart: ${product.name}`);
        // You can dispatch a Vuex action or use another state management method to manage the cart
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
  /* Header Section Styling */
  .navbar {
    background-color: #000;
    color: white;
    padding: 15px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .navbar .logo {
    font-size: 2rem;
    font-weight: bold;
    color: #E60000; /* Red */
    text-decoration: none;
  }
  .navbar .nav-links a {
    color: white;
    text-decoration: none;
    font-weight: bold;
    margin: 0 15px;
  }
  .navbar .nav-links a:hover {
    color: #E60000; /* Red on hover */
  }
  /* Hero Section Styling */
  /* Hero Section with Background Image */
  .hero-banner {
    position: relative;
    width: 100%;
    height: 100vh; /* Full height of the viewport */
    background-image: url('https://images.pexels.com/photos/1229356/pexels-photo-1229356.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'); /* Replace with your image URL */
    background-size: cover; /* Ensures the image covers the entire section */
    background-position: center; /* Centers the image */
    background-repeat: no-repeat;
    overflow: hidden;
  }
  .hero-content {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    color: white; /* Ensure text is readable on the image */
    z-index: 1; /* Make sure the text is on top of the image */
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
    background-color: #333; /* Darker black on hover */
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
    grid-template-columns: repeat(3, 1fr);
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
  .product-card h3 {
    font-size: 1.5rem;
    color: #000;
    margin-bottom: 10px;
  }
  .product-description {
    font-size: 1rem;
    color: #555;
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
    color: white;
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
    background-color: #222; /* Dark black background */
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
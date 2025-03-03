<template>
  <section class="product-details-container">
    <div class="product-content">
      <!-- Product Details -->
      <div class="product-info">
        <img :src="product.image" :alt="product.name" class="product-image" />
        <h3>{{ product.name }}</h3>
        <p>{{ product.description }}</p>
        <p>Price: R{{ product.price }}</p>
      </div>

      <!-- Reviews Section (Now on the Right) -->
      <div class="reviews-container">
        <section class="reviews-section">
          <h4>Customer Reviews</h4>
          <div v-if="reviews.length === 0">
            <p>No reviews available.</p>
          </div>
          <div v-else>
            <div v-for="review in reviews" :key="review.id" class="review-card">
              <h5>{{ review.user }}</h5>
              <p>{{ review.comment }}</p>
              <div>
                <span v-for="star in 5" :key="star" class="star">
                  {{ star <= review.rating ? '★' : '☆' }}
                </span>
              </div>
            </div>
          </div>
        </section>

        <!-- Leave a Review Section -->
        <section class="leave-review">
          <h5>Leave a Review</h5>
          <input v-model="newReview.user" placeholder="Your Name" />
          <textarea v-model="newReview.comment" placeholder="Write your review..." />
          <select v-model="newReview.rating">
            <option value="" disabled>Select Rating</option>
            <option v-for="n in 5" :key="n" :value="n">{{ n }} Stars</option>
          </select>
          <button @click="submitReview">Submit Review</button>
        </section>
      </div>
    </div>
  </section>
</template>

<script>
import { computed, ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import { useStore } from 'vuex';

export default {
  setup() {
    const store = useStore();
    const route = useRoute();
    const productId = route.params.id;

    const product = computed(() => store.getters.allProducts.find(p => p.id == productId));
    const reviews = computed(() => store.getters.productReviews(productId));

    const newReview = ref({
      user: '',
      comment: '',
      rating: ''
    });

    onMounted(() => {
      store.dispatch('fetchReviews', productId);
    });

    const submitReview = () => {
      if (!newReview.value.user || !newReview.value.comment || !newReview.value.rating) {
        alert("Please fill in all fields!");
        return;
      }
      store.dispatch('submitReview', { ...newReview.value, productId });
      newReview.value = { user: '', comment: '', rating: '' };
    };

    return { product, reviews, newReview, submitReview };
  }
};
</script>

<style scoped>
/* Main Container */
.product-details-container {
  max-width: 1000px;
  margin: 0 auto;
  padding: 20px;
  background-color: #f4f4f4;
  border-radius: 8px;
  display: flex;
  justify-content: center; /* Center the content horizontally */
  align-items: center;     /* Center the content vertically */
  flex-direction: column;  /* Make sure the layout stacks vertically on smaller screens */
}

/* Layout: Product Info on Left, Reviews on Right */
.product-content {
  display: flex;
  gap: 20px;
  align-items: flex-start;
  justify-content: center; /* Center the content horizontally */
  width: 100%; /* Ensure it fills the available space */
}

/* Left Section: Product Details */
.product-info {
  flex: 1;
  background-color: white;
  padding: 20px;
  border-radius: 8px;
  text-align: center; /* Center the text and content inside */
}

.product-image {
  width: 350px;         /* Set the width to 350px */
  height: 350px;        /* Set the height to 350px (square shape) */
  object-fit: cover;    /* Ensure the image covers the entire area without distortion */
  border-radius: 8px;   /* Rounded corners */
  display: block;       /* Make the image a block element to avoid unwanted spacing */
  margin: 0 auto;       /* Center the image horizontally */
}

/* Right Section: Reviews */
.reviews-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 20px;
  justify-content: center; /* Center the content inside */
}

/* Reviews */
.reviews-section {
  background-color: white;
  padding: 15px;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  text-align: center; /* Center the content in the review section */
}

.review-card {
  background-color: #fff;
  padding: 10px;
  margin-top: 10px;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  text-align: left; /* Align review text to the left */
}

.star {
  color: gold;
  margin-right: 5px;
}

/* Leave a Review */
.leave-review {
  background-color: white;
  padding: 15px;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  text-align: center; /* Center the form content */
}

.leave-review input,
.leave-review textarea,
.leave-review select {
  width: 100%;
  padding: 10px;
  margin: 5px 0;
  border-radius: 8px;
  border: 1px solid #ccc;
}

.leave-review button {
  background-color: red;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
}

.leave-review button:hover {
  background-color: #c00;
}

/* Responsive Layout */
@media (max-width: 768px) {
  .product-content {
    flex-direction: column;  /* Stack items vertically on smaller screens */
    align-items: center;     /* Center the content on mobile */
  }
}
</style>

<template>
  <div class="product-details-container">
    <div v-if="loading">Loading product details...</div>

    <!-- product info -->
    <div v-else-if="product" class="product-content">
      <div class="product-info">
        <img :src="product.image" alt="Product Image" class="product-image">
        <p class="style"><strong>Price:</strong> R{{ product.price }}</p>
        <p class="style"><strong>Description:</strong> {{ product.description }}</p>
      </div>
      <!-- reviews container -->
      <div class="reviews-container">
        <h2 class="hs">Reviews for this Product</h2>
        <div v-if="productReviews.length > 0" class="reviews-section">
          <div v-for="review in productReviews" :key="review.review_id" class="review-card">
            <p><strong>Rating:</strong> {{ review.rating }}</p>
            <p><strong>Comment:</strong> {{ review.comment }}</p>
            <p><strong>User:</strong> {{ review.name }}</p>
            <hr>
          </div>
        </div>
        <div v-else>
          <p class="style">No reviews yet for this product.</p>
        </div>
        <div v-if="isLoggedIn">
          <h2 class="hs">Add a Review</h2>

          <!-- form to add review -->
          <form @submit.prevent="addReview" class="leave-review">
            <label for="rating" class="rating">Rating:</label>
            <select id="rating" v-model="newReview.rating" required>
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
            </select>
            <label class="hs" for="comment">Comment:</label>
            <textarea id="comment" v-model="newReview.comment" required></textarea>
            <button type="submit">Submit Review</button>
          </form>
        </div>
        <div v-else>
          <p class="style">Please log in to add a review.</p>
        </div>
      </div>
    </div>
    <div v-else>
      <p>Product not found.</p>
    </div>
  </div>
</template>

<script>
// imports
import { ref, onMounted, computed } from 'vue';
import { useStore } from 'vuex';

export default {
  // props
  props: {
    productId: {
      type: Number,
      required: true,
      default: 0,
    },
  },
  setup(props) {
    const product = ref(null);
    const productReviews = ref([]);
    const loading = ref(true);
    const newReview = ref({
      rating: 5,
      comment: '',
    });

    const store = useStore();
    const isLoggedIn = computed(() => !!store.state.user);

    // fetch api's
    onMounted(async () => {
      try {
        const productResponse = await fetch(`http://localhost:3000/api/products/${props.productId}`);
        if (productResponse.ok) {
          product.value = await productResponse.json();
        } else {
          product.value = null;
        }
        const productReviewsResponse = await fetch(`http://localhost:3000/api/reviews/product?product_id=${props.productId}`);
        if (productReviewsResponse.ok) {
          productReviews.value = await productReviewsResponse.json();
          console.log(productReviews.value);
        } else {
          productReviews.value = [];
        }
      } catch (error) {
        console.error('Error fetching data:', error);
        product.value = null;
        productReviews.value = [];
      } finally {
        loading.value = false;
      }
    });

    // add review method
    const addReview = async () => {
      try {
        const response = await fetch('http://localhost:3000/api/reviews', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            product_id: props.productId,
            user_id: store.state.user.user_id, // Accessing user_id
            rating: newReview.value.rating,
            comment: newReview.value.comment,
          }),
        });
        if (response.ok) {
          const addedReview = await response.json();
          productReviews.value.push(addedReview);
          newReview.value = { rating: 5, comment: '' };
          alert('Review added successfully!');
          // location.reload()
        } else {
          alert('Failed to add review.');
        }
      } catch (error) {
        console.error('Error adding review:', error);
        alert('An error occurred while adding the review.');
      }
    };

    return {
      product,
      productReviews,
      loading,
      newReview,
      addReview,
      isLoggedIn,
    };
  },
};
</script>

<style scoped>
/* styles */
.product-details-container {
  max-width: 1000px;
  margin: 0 auto;
  padding: 20px;
  background-color: #F4F4F4;
  border-radius: 8px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}

.product-content {
  display: flex;
  gap: 20px;
  align-items: flex-start;
  justify-content: center;
  width: 100%;
  flex-wrap: wrap;
}

.rating {
  color: red;
}

.product-info {
  flex: 1;
  margin-top: 50px;
  background-color: white;
  padding: 15px;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  text-align: center;
}

.product-image {
  max-width: 300px;
  border-radius: 8px;
}

.reviews-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 20px;
  justify-content: center;
  min-width: 300px;
}

.reviews-section {
  background-color: white;
  padding: 15px;
  color: black;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  text-align: center;
}

.review-card {
  background-color: #fff;
  padding: 10px;
  margin-top: 10px;
  color: black;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  text-align: left;
}

.leave-review {
  background-color: white;
  padding: 15px;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  text-align: center;
}

.leave-review input,
.leave-review textarea,
.leave-review select {
  width: 100%;
  padding: 10px;
  margin: 5px 0;
  border-radius: 8px;
  border: 1px solid #ccc;
  box-sizing: border-box;
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

@media (max-width: 768px) {
  .product-content {
    flex-direction: column;
    align-items: center;
  }
  .reviews-container {
    min-width: 100%;
  }
}

.style {
  color: black;
}

.hs {
  color: #c00;
}

</style>
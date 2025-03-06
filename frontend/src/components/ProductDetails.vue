<template>
  <div v-if="loading">Loading product details...</div>
  <div v-else-if="product">
    <!-- <h1>{{ product.name }}</h1>
    <img :src="product.image" alt="Product Image" style="max-width: 300px;">
    <p><strong>Price:</strong> ${{ product.price }}</p>
    <p><strong>Description:</strong> {{ product.description }}</p>
    <p><strong>Category:</strong> {{ product.category }}</p> -->
    <h2>Reviews for this Product</h2>

    <div v-if="productReviews.length > 0">
      <div v-for="review in productReviews" :key="review.review_id">
        <p><strong>Rating:</strong> {{ review.rating }}</p>
        <p><strong>Comment:</strong> {{ review.comment }}</p>
        <p><strong>User ID:</strong> {{ review.user_id }}</p>
        <hr>
      </div>
    </div>
    <div v-else>
      <p>No reviews yet for this product.</p>
    </div>

    <h2>Add a Review</h2>
    <form @submit.prevent="addReview">
      <label for="rating">Rating:</label>
      <select id="rating" v-model="newReview.rating" required>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
      </select>

      <label for="comment">Comment:</label>
      <textarea id="comment" v-model="newReview.comment" required></textarea>

      <button type="submit">Submit Review</button>
    </form>
  </div>
  <div v-else>
    <p>Product not found.</p>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue';

export default {
  props: {
    productId: {
      type: Number,
      required: true,
      default:0
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

    onMounted(async () => {
      try {
        const productResponse = await fetch(`http://localhost:3000/api/products/${props.productId}`);
        if (productResponse.ok) {
          product.value = await productResponse.json();
          
        } else {
          product.value = null;
        }
        
        const productReviewsResponse = await fetch(`http://localhost:3000/api/reviews?product_id=${props.productId}`);
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

    const addReview = async () => {
      try {
        const response = await fetch('http://localhost:3000/api/reviews', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            product_id: props.productId,
            user_id: 1, // Replace with actual user ID
            rating: newReview.value.rating,
            comment: newReview.value.comment,
          }),
        });

        if (response.ok) {
          const addedReview = await response.json();
          productReviews.value.push(addedReview);
          newReview.value = { rating: 5, comment: '' }; //reset form
          alert('Review added successfully!');
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
    };
  },
};
</script>

<style scoped>
/* Add your styling here */
</style>
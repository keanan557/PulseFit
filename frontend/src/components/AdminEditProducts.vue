<template>
  <div class="product-container">
    <div>
      <h1 class="product-title">Product List</h1>
      <table class="product-table">
        <thead>
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Image</th>
            <th>Quantity</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="product in products" :key="product.product_id">
            <td>{{ product.product_id }}</td>
            <td class="product-name">{{ product.name }}</td>
            <td>{{ product.description }}</td>
            <td class="product-price">{{ product.price }}</td>
            <td>
                <img :src="product.image" alt="Product Image" class="product-image">
            </td>
            <td>{{ product.quantity }}</td>
            <td>
              <button class="edit-button" @click="editProduct(product)">Edit</button>
              <button class="remove-button" @click="deleteProduct(product.product_id)">Remove</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Modal for Editing -->
    <div v-if="showModal" class="modal">
      <div class="modal-content">
        <h3>Edit Product</h3>
        <label>ID: </label>
        <input type="text" v-model="product.product_id" disabled>
        <br><br>
        <label>Name: </label>
        <input type="text" v-model="product.name">
        <br><br>
        <label>Description: </label>
        <input type="text" v-model="product.description">
        <br><br>
        <label>Price: </label>
        <input type="number" v-model="product.price">
        <br><br>
        <label>Image URL: </label>
        <input type="text" v-model="product.image" placeholder="Enter URL">
        <br><br>
        <label>Quantity: </label>
        <input type="number" v-model="product.quantity">
        <br><br>
        <div class="modal-buttons">
          <button class="save-button" @click="updateProduct">Save Changes</button>
          <button class="cancel-button" @click="closeModal">Cancel</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      products: [],
      showModal: false,
      product: { product_id: '', name: '', description: '', price: '', image: '', quantity: '' },
    };
  },
  methods: {
    async fetchProducts() {
      const response = await fetch('http://localhost:3000/api/products');
      this.products = await response.json();
    },
    editProduct(product) {
      this.product = { ...product };
      this.showModal = true;
    },
    async updateProduct() {
      const response = await fetch(`http://localhost:3000/api/products/${this.product.product_id}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          name: this.product.name,
          description: this.product.description,
          price: this.product.price,
          image: this.product.image,
          quantity: this.product.quantity
        }),
      });
      if (response.ok) {
        this.fetchProducts();
        this.showModal = false;
      }
    },
    async deleteProduct(id) {
      const response = await fetch(`http://localhost:3000/api/products/${id}`, {
         method: 'DELETE' 
        
        });
      if (response.ok) {
        this.fetchProducts();
      } else {
        console.error("Failed to delete");
      }
    },
    closeModal() {
      this.showModal = false;
    },
  },
  mounted() {
    this.fetchProducts();
  },
};
</script>

<style scoped>
.product-container {
  background-color: #fff;
  color: #000;
  padding: 20px;
  border-radius: 8px;
  text-align: center;
  transition: transform 0.3s ease;
}

.product-title {
  color: red;
  font-size: 2rem;
  margin-bottom: 20px;
}

.product-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

.product-table th,
.product-table td {
  border: 1px solid #000;
  padding: 10px;
  text-align: center;
}

.product-name {
  color: rgb(8, 8, 8);
  font-weight: bold;
}

.product-price {
  color: #000;
}

.product-image {
  width: 50px;
  height: 50px;
  object-fit: cover;
  border-radius: 4px;
}

.edit-button,
.remove-button,
.save-button,
.cancel-button {
  background-color: red;
  color: #fff;
  border: none;
  padding: 8px 16px;
  cursor: pointer;
  border-radius: 4px;
  margin: 5px;
}

.edit-button:hover,
.remove-button:hover,
.save-button:hover {
  background-color: #c00;
}

.modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
}

.modal-content {
  background: white;
  padding: 20px;
  border-radius: 8px;
  text-align: center;
  color: #000;
}

.modal-buttons {
  margin-top: 10px;
}

.cancel-button {
  background-color: gray;
}

.cancel-button:hover {
  background-color: darkgray;
}
</style>

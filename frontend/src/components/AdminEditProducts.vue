<template>
    <div>
      <table>
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
          <tr v-for="product in products" :key="product.id">
            <td>{{ product.id }}</td>
            <td>{{ product.name }}</td>
            <td>{{ product.description }}</td>
            <td>{{ product.price }}</td>
            <td>
                <img :src="'http://localhost:3000/uploads/' + product.image" alt="Product Image" width="50">
            </td>
            <td>{{ product.quantity }}</td>
            <td>
              <button @click="editProduct(product)">Edit</button>
              <button @click="deleteProduct(product.id)">Remove</button>
            </td>
          </tr>
        </tbody>
      </table>
      <!-- Modal for Editing -->
      <div v-if="showModal" class="modal">
        <div class="modal-content">
          <h3>Edit Product</h3>
          <label>ID: </label>
          <input type="text" v-model="product.id" disabled>
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
          <label>Image: </label>
          <input type="file" @change="handleImageUpload" accept="image/*">
          <br><br>
          <label>Quantity: </label>
          <input type="number" v-model="product.quantity">
          <br><br>
          <button @click="updateProduct">Save Changes</button>
          <button @click="closeModal">Cancel</button>
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
        product: { id: '', name: '', description: '', price: '', image: '', quantity: '' },
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
        const response = await fetch(`http://localhost:3000/api/products/${this.product.id}`, {
          method: 'PATCH',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(this.product),
        });
        if (response.ok) {
          this.fetchProducts();
          this.showModal = false;
        }
      },
      async deleteProduct(id) {
        const response = await fetch(`http://localhost:3000/api/products/${id}`, { method: 'DELETE' });
        if (response.ok) this.fetchProducts();
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
  <style>
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
    border-radius: 5px;
  }
  </style>
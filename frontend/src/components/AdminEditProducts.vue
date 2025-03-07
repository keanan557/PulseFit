<template>
  <div class="product-container">
    <h1 class="product-title">Product List</h1>
    <div class="table-responsive">
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

    <div v-if="showModal" class="modal">
      <div class="modal-content">
        <h3>Edit Product</h3>
        <label>ID: </label>
        <input type="text" v-model="product.product_id" disabled>
        <label>Name: </label>
        <input type="text" v-model="product.name">
        <label>Description: </label>
        <input type="text" v-model="product.description">
        <label>Price: </label>
        <input type="number" v-model="product.price">
        <label>Image URL: </label>
        <input type="text" v-model="product.image" placeholder="Enter URL">
        <label>Quantity: </label>
        <input type="number" v-model="product.quantity">
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
      try{
        const response = await fetch('http://localhost:3000/api/products');
        this.products = await response.json();
      } catch (error) {
        console.error("Error fetching products:", error);
      }
    },
    editProduct(product) {
      this.product = { ...product };
      this.showModal = true;
    },
    async updateProduct() {
      try {
        const response = await fetch(`http://localhost:3000/api/products/${this.product.product_id}`, {
          method: 'PATCH',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(this.product),
        });
        if (response.ok) {
          this.fetchProducts();
          this.showModal = false;
        } else {
          console.error("Failed to update product");
        }
      } catch (error) {
        console.error("Error updating product:", error);
      }
    },
    async deleteProduct(id) {
      try{
        const response = await fetch(`http://localhost:3000/api/products/${id}`, { method: 'DELETE' });
        if (response.ok) {
          this.fetchProducts();
        } else {
          console.error("Failed to delete product");
        }
      } catch (error) {
        console.error("Error deleting product:", error);
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
  padding: 20px;
}

.product-title {
  color: red;
  font-size: 2rem;
  margin-bottom: 20px;
  text-align: center;
}

.table-responsive {
  overflow-x: auto;
}

.product-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

.product-table th,
.product-table td {
  border: 1px solid #ddd;
  padding: 10px;
  text-align: left;
}

.product-table th {
  background-color: black;
}

.product-name {
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
  padding: 8px 12px;
  margin: 5px;
  cursor: pointer;
  border: none;
  border-radius: 4px;
}

.edit-button, .save-button {
  background-color: white;
  color: black;
  border: 1px solid red;
}

.remove-button, .cancel-button {
  background-color: #f44336;
  color: white;
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
  z-index: 1000;
}

.modal-content {
  background: white;
  padding: 20px;
  border-radius: 8px;
  text-align: center;
  color: #000;
  width: 300px;
}

.modal-buttons {
  margin-top: 10px;
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .product-table th,
  .product-table td {
    padding: 8px;
    font-size: 0.9em;
  }
}

@media (max-width: 576px) {
  .product-table th,
  .product-table td {
    padding: 6px;
    font-size: 0.8em;
  }

  .product-image {
    width: 40px;
    height: 40px;
  }
}
</style>
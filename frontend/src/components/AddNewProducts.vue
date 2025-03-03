<template>
    <h1>Add New Products</h1>

    <label>Name: </label>
    <input type="text" v-model="name" required>
<br><br>
    <label>Description: </label>
    <input type="text" v-model="description" required>
    <br><br>
    <label>Price: </label>
    <input type="number" v-model="price" required>
    <br><br>
    <label>Image URL: </label>
    <input type="text" v-model="imageUrl" placeholder="Enter image URL">
    <br><br>

    <label>quanity: </label>
    <input type="number" v-model="quantity">
    <br><br>
    <button @click="submitProduct">+ Add New</button>
</template>

<script>
export default {
  name: "AddNewProducts",
  data() {
    return {
      name: "",
      description: "",
      price: null,
      quantity: null,
      imageUrl: ""
    };
  },
  methods: {
    async submitProduct() {
      if (!this.name || !this.description || !this.price || !this.imageUrl) {
        alert("Please fill all fields and provide an image URL");
        return;
      }

      const productData = {
        name: this.name,
        description: this.description,
        price: this.price,
        quantity: this.quantity ? this.quantity : 0,
        image: this.imageUrl // using the image URL provided
      };

      try {
        const response = await fetch("http://localhost:3000/api/products", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(productData)
        });
        const result = await response.json();
        if (response.ok) {
          alert("Product added successfully!");
          // Optionally reset form fields:
          this.name = "";
          this.description = "";
          this.price = null;
          this.quantity = null;
          this.imageUrl = "";
        } else {
          alert("Error: " + result.error);
        }
      } catch (error) {
        console.error("Error adding product:", error);
        alert("An error occurred. Please try again.");
      }
    }
  }
};

  
</script>
<template>
  <div class="background">
    <h1>Add New Product</h1>
    <form @submit.prevent="submitProduct">
      <label>Name: </label>
      <input type="text" v-model="name" required />
      <br /><br />

      <label>Description: </label>
      <input type="text" v-model="description" required />
      <br /><br />

      <label>Price: </label>
      <input type="number" v-model="price" required />
      <br /><br />

      <label>Image URL: </label>
    <input type="text" v-model="imageUrl" placeholder="Enter image URL">
    <br><br>

      <label>Quantity: </label>
      <input type="number" v-model="quantity" />
      <br /><br />

      <button type="submit">+ Add New</button>
    </form>
  </div>
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


<style scoped>
/* Background Styling */
.background {
  background-image: url('@/assets/adult-1850925_1280.jpg');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  height: 100vh; /* Make background cover full screen */
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  color: #fff;
  padding: 20px; /* Add some padding to the sides */
}

/* Header */
h1 {
  text-align: center;
  color: #fff;
  font-size: 28px;
  font-weight: bold;
  margin-bottom: 20px;
}

/* Form Styling */
form {
  width: 100%;
  max-width: 600px; /* Limit max width */
  padding: 20px;
  background: rgba(0, 0, 0, 0.6); /* Transparent background */
  border-radius: 8px;
  box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.5);
  backdrop-filter: blur(10px);
}

/* Label Styling */
label {
  font-size: 14px;
  font-weight: bold;
  display: block;
  margin-top: 10px;
  color: #fff;
  margin-bottom: 5px; /* Add a little margin below the label */
}

/* Input Fields */
input {
  width: 100%;
  padding: 12px; /* Increase padding for better spacing */
  margin-top: 5px;
  margin-bottom: 15px; /* Add bottom margin for spacing between fields */
  border: 1px solid #bbb;
  border-radius: 8px;
  font-size: 14px;
  background: #FEFEFE;
  transition: all 0.3s ease;
  box-sizing: border-box; /* Make sure padding and borders are included in the element's total width/height */
}

/* Input Focus */
input:focus {
  border-color: #FF6600;
  box-shadow: 0px 0px 8px rgba(255, 102, 0, 0.5);
  outline: none;
}

/* Button Styling */
button {
  width: 100%;
  padding: 14px;
  background: linear-gradient(to right, #ff0000, #FF0000);
  color: white;
  border: none;
  border-radius: 8px;
  margin-top: 20px;
  cursor: pointer;
  font-size: 16px;
  font-weight: bold;
  transition: all 0.3s ease;
}

button:hover {
  background: linear-gradient(to right, #FF3300, #CC2900);
}

button:active {
  transform: scale(0.97);
}
</style>

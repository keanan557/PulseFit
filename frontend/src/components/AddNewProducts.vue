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
    <label>Image: </label>
    <input type="file" @change="handleImageUpload" accept="image/*">
    <br><br>

    <label>quanity: </label>
    <input type="number" v-model="quantity">
    <br><br>
    <button @click="submitProduct">+ Add New</button>
</template>

<script>
export default{
      data(){
        return{
            name: '',
            description:'',
            price: null,
            quantity: null,
            image: null,

        }
    },
    methods: {
        handleImageUpload(event) {
            const file = event.target.files[0];
            if (file) {
                this.image = file;

                // Preview the image
                // const reader = new FileReader();
                // reader.readAsDataURL(file);
                // reader.onload = () => {
                //     this.imagePreview = reader.result;
                // };
            }
        },

        async submitProduct(){
            if(!this.name || !this.description || !this.price || !this.image){
                alert("Please fill all fields and upload image")
                return
            }

            const formData = new FormData()
            formData.append("name", this.name)
            formData.append("description", this.description)
            formData.append("price", this.price)
            formData.append("quantity", this.quantity ? this.quantity : 0)
            formData.append("image",this.image)

            const response = await fetch("http://localhost:3000/api/products", {
    method: "POST",
    body: formData
});

const text = await response.text(); // Debug raw response
console.log("Raw response:", text);

try {
    const result = JSON.parse(text);
    if (response.ok) {
        alert("Product added successfully!");
    } else {
        alert("Error: " + result.message);
    }
} catch (error) {
    console.error("JSON Parsing Error:", error);
    alert("Failed to parse server response.");
}

        }
    }
}
  
</script>
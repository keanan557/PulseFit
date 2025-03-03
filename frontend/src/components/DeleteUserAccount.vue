<template>
    <h1>Delete my Account</h1>

    <!-- if logged in allow user to enter email and delete account -->
    <label>Enter your email:</label>
    <input type="email" v-model="email">
    <button @click="confirmDelete">Delete my account</button>

    <div v-if="showModal" class="my-modal">
        <label>Are you sure you want to delete?</label>
        <button @click="deleteAccount">Yes</button>
        <button @click="showModal = false">No</button>
    </div>

    <p v-if="message">{{ message }}</p>
</template>

<script>
import {ref} from "vue"

export default {
    setup(){
        const email = ref("")
        const showModal = ref(false)
        const message = ref("")
        
        const confirmDelete = () =>{
            message.value=""
            if(!email.value){
                message.value = "Please enter email"
                return
            }
            showModal.value = true
        }
        
    

    const deleteAccount = async ()=>{
        try{
            const response = await fetch("http://localhost:3000/api/delete-account",{
                method: "DELETE",
                headers: {"Content-Type": "application/json"},
                body: JSON.stringify({email: email.value})
            })

            const data = await response.json()
            if (!response.ok) throw new Error(data.error || "Failed to delete account")

            message.value = "Your account has been deleted"
        }catch(error){
            message.value = error.message
        }finally{
            showModal.value = false
        }
    };
    return{email, showModal, message, confirmDelete, deleteAccount};
}
    
}

</script>

<style>
    .my-modal{
        display: block;
    }
</style>
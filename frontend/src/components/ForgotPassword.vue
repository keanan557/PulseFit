<template>
    <h1>Forgot password</h1>

    <label>Email</label>
    <input type="text" v-model="email">
<br>
    <button @click="toggleModal">Reset Password</button>


    <div v-if="showModal" class="new-password-modal">
        <input type="password" placeholder="enter a new password" v-model="newPassword">
        <br>
        <input type="password" placeholder="Confirm new password" v-model="confirmPassword">
        <br>
        <button @click="resetPassword">Create New Password</button>


    </div>



    <p v-if="message" :class="{error:error,success:success}">{{ message }}</p>
</template>

<script>
import {ref} from 'vue';

export default {
    name: 'ForgotPassword',
    setup(){
        const email = ref('')
        const newPassword = ref('')
        const confirmPassword = ref('')
        const showModal = ref(false)
        const message = ref('')
        const error = ref(false)
        const success = ref(false)


        const toggleModal = () => {
            showModal.value = !showModal.value
            message.value = ''
            error.value = false
            success.value = false
        }

        const resetPassword = async () => {
            if(newPassword.value !== confirmPassword.value) {
                message.value = "Passwords do not match"
                error.value = true
                return
            }

            if(!email.value || !newPassword.value){
                message.value = "Email and new password are required"
                error.value = true
                return
            }
            error.value = false
            success.value = false
            message.value = ""
            try{
                const response = await fetch ("http://localhost:3000/api/reset-password",{
                    method: "POST",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify({
                        email: email.value,
                        newPassword: newPassword.value
                    })
                })
                const data = await response.json()
                if(response.ok){
                    message.value = data.message || "Password reset successful"
                    error.value = true
                }
            }catch(err){
                console.error("reset password:", err)
                message.value = "error occured"
                error.value = true
            }


        }

        return{
            email,
            newPassword,
            confirmPassword,
            showModal,
            message,
            error,
            success,
            toggleModal,
            resetPassword
        }
    }
}
    
</script>

<style>

</style>
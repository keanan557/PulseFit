<template>
    <div class="forgot-password-container">
        <h1>Forgot Password</h1>
        <label>Email</label>
        <input type="email" v-model="email" placeholder="Enter your email" class="input-field" />
        <br />
        <button @click="toggleModal" class="btn">Reset Password</button>
        <div v-if="showModal" class="new-password-modal">
            <input type="password" placeholder="Enter a new password" v-model="newPassword" class="input-field" />
            <br />
            <input type="password" placeholder="Confirm new password" v-model="confirmPassword" class="input-field" />
            <br />
            <button @click="resetPassword" class="btn">Create New Password</button>
        </div>
        <p v-if="message" :class="{ error: error, success: success }">{{ message }}</p>
    </div>
</template>
<script>
import { ref } from 'vue';
export default {
    name: 'ForgotPassword',
    setup() {
        const email = ref('');
        const newPassword = ref('');
        const confirmPassword = ref('');
        const showModal = ref(false);
        const message = ref('');
        const error = ref(false);
        const success = ref(false);
        const toggleModal = () => {
            showModal.value = !showModal.value;
            message.value = '';
            error.value = false;
            success.value = false;
        };
        const resetPassword = async () => {
            if (newPassword.value !== confirmPassword.value) {
                message.value = 'Passwords do not match';
                error.value = true;
                return;
            }
            if (!email.value || !newPassword.value) {
                message.value = 'Email and new password are required';
                error.value = true;
                return;
            }
            error.value = false;
            success.value = false;
            message.value = '';
            try {
                // fetch api
                const response = await fetch('http://localhost:3000/api/reset-password', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        email: email.value,
                        newPassword: newPassword.value,
                    }),
                });
                const data = await response.json();
                if (response.ok) {
                    message.value = data.message || 'Password reset successful';
                    success.value = true;
                } else {
                    error.value = true;
                }
            } catch (err) {
                console.error('reset password:', err);
                message.value = 'Error occurred';
                error.value = true;
            }
        };
        return {
            email,
            newPassword,
            confirmPassword,
            showModal,
            message,
            error,
            success,
            toggleModal,
            resetPassword,
        };
    },
};
</script>
<style scoped>
.forgot-password-container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    max-width: 500px; /* Increased width of the container */
    margin: 0 auto;
    padding: 30px; /* Increased padding for better spacing */
    background-color: #F9F9F9;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgb(0, 0, 0);
    text-align: center;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}
.forgot-password-container input,
.forgot-password-container button {
    width: 100%;
    padding: 12px; /* Increased padding for input and button */
    margin: 10px 0;
    border-radius: 4px;
    font-size: 14px;
}
.forgot-password-container input {
    border: 1px solid #ccc;
}
.forgot-password-container button {
    background-color: #000;
    color: white;
    border: none;
    cursor: pointer;
    font-size: 16px;
}
.forgot-password-container button:hover {
    background-color: #FF0000;
}
.forgot-password-container h1 {
    margin-bottom: 20px;
    font-size: 1.8em; /* Adjusted heading size */
}
.new-password-modal {
    margin-top: 20px;
}
p {
    margin-top: 20px;
    font-size: 14px;
}
.error {
    color: red;
}
.success {
    color: green;
}
/* Responsive Styles */
@media (max-width: 768px) {
    .forgot-password-container {
        max-width: 80%; /* Decreased width for smaller screens */
        padding: 20px;
    }
    .input-field {
        font-size: 16px;
    }
    .btn {
        font-size: 16px;
    }
    h1 {
        font-size: 1.6em;
    }
    .new-password-modal {
        padding: 15px;
    }
}
@media (max-width: 480px) {
    .forgot-password-container {
        max-width: 95%; /* Even smaller width on very small screens */
        padding: 15px;
    }
    .input-field {
        font-size: 16px;
    }
    .btn {
        font-size: 16px;
    }
    h1 {
        font-size: 1.4em;
    }
    .new-password-modal {
        padding: 15px;
    }
    p {
        font-size: 0.9em;
    }
}
</style>
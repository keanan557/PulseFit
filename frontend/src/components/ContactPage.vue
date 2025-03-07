<template>
  <div class="contact-container">
    <h1>Contact Page</h1>

    <label>Name: </label>
    <input type="text" v-model="name" />
    <div v-if="errors.name" class="error">{{ errors.name }}</div>

    <br />

    <label>Email: </label>
    <input type="email" v-model="email" />
    <div v-if="errors.email" class="error">{{ errors.email }}</div>

    <br />

    <label>Message</label>
    <textarea type="text" v-model="message"></textarea>
    <div v-if="errors.message" class="error">{{ errors.message }}</div>

    <br />

    <button @click="sendContact">Send</button>
  </div>
</template>

<script>
import {ref} from 'vue'

export default {
    setup(){
        const name = ref('')
        const email = ref('')
        const message = ref('')
        const errors = ref({})

        const sendContact = async () => {

          errors.value = {}; // Reset errors

            if (!name.value) {
                errors.value.name = 'Name is required.';
            }
            if (!email.value) {
                errors.value.email = 'Email is required.';
            } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) {
                errors.value.email = 'Invalid email format.';
            }
            if (!message.value) {
                errors.value.message = 'Message is required.';
            }

            if (Object.keys(errors.value).length > 0) {
                return; // Stop if there are errors
            }

      try {
        const response = await fetch('http://localhost:3000/api/contact', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ name: name.value, email: email.value, message: message.value }),
        });

        if (response.ok) {
          alert('Message sent successfully!');
          name.value = '';
          email.value = '';
          message.value = '';
        } else {
          alert('Failed to send message.');
        }
      } catch (error) {
        console.error('Error sending message:', error);
        alert('An error occurred while sending the message.');
      }
    };

    return {
      name,
      email,
      message,
      sendContact,
      errors
    };
    
}
}

</script>

<style>
.contact-container{
  display: flex;
  flex-direction: column;
  align-items: center;
  font-size: 20px;
  font-family: Arial, Helvetica, sans-serif;
 
}

.contact-container input{
  width: 300px;
  border-radius: 5px;
}

.contact-container textarea{
  width: 300px;
  border-radius: 10px;
}

.contact-container button{
  width: 200px;
  background: red;
  color: white;
  height: 30px;
  border-radius: 30px;
  cursor: pointer;
}

textarea{
    width: 300px;
    min-height: 100px;
    resize: vertical;
}

.error {
    color: red;
    font-size: 12px;
}

</style>